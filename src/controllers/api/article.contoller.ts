import { Body, Controller, Delete, Param, Patch, Post, Req, UploadedFile, UseGuards, UseInterceptors} from "@nestjs/common";
import { FileInterceptor } from "@nestjs/platform-express";
import { Crud } from "@nestjsx/crud";
import { StorageConfig } from "config.ts/storage.config";
import { Article } from "src/entities/article.entity";
import { AddArticleDto } from "src/dtos/article/add.article.dto";
import { ArticleService } from "src/services/article/article.service";
import {diskStorage} from "multer";
import { PhotoService } from "src/services/photo/photo.service";
import { Photo } from "src/entities/photo.entity";
import { ApiResponse } from "src/misc/api.response.class";
//import * as fileType from 'file-type'; 
import * as fs from 'fs';
import * as sharp from 'sharp';
import { EditAdministratorDto } from "src/dtos/administrator/edit.administrator.dto";
import { EditArticleDto } from "src/dtos/article/edit.article.dto";
import { ArticlePrice } from "src/entities/article-price.entity";
import { RoleCheckedGuard } from "src/misc/role.checker.guard";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";
import { ArticleSearchDto } from "src/dtos/article/article.search.dto";


const fileType = require("file-type");
 
@Controller('api/article')
@Crud({
    model:{
        type:Article
    },
    params:{
        id:{
            field:'articleId',
            type:'number',
            primary:true
        }
    },
    query:{
        join:{
            category:{
                eager:true
            },
            photos:{
                eager:true
            },
            articlePrices:{
                eager:true
            },
            articleFeatures:{
                eager:true
            },
            features:{
                eager:true
            }
             
        }
    },

    routes:{
        only:[
            'getManyBase',
            'getOneBase',
        ],
        getOneBase:{
            decorators:[
                UseGuards(RoleCheckedGuard),
                AllowToRoles('administrator','user')
            ],
        },
        getManyBase:{
            decorators:[
                UseGuards(RoleCheckedGuard),
                AllowToRoles('administrator','user')
            ],
        },
    }
})
export class ArticleController{
    constructor(public service:ArticleService,
                public photoService:PhotoService){

    }

    
    @Post()
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator')
    createFullArticle(@Body() data:AddArticleDto){
        return this.service.createFullArticle(data);
    }

    @Patch(':id')
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator')
    editFullArticle(@Param('id') id:number, @Body() data:EditArticleDto){
        return this.service.editFullArticle(id, data); 
    }

    @Post(':id/uploadPhoto/') // POST http://localhost:3000/api/article/:id/uploadPhoto/
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator')
    @UseInterceptors(
        FileInterceptor('photo', {
            storage: diskStorage({
                destination: StorageConfig.photo.destination,
                filename: (req, file, callback) => {
                    let original: string = file.originalname;

                    let normalized = original.replace(/\s+/g, '-');
                    normalized = normalized.replace(/[^A-z0-9\.\-]/g, '');
                    let sada = new Date();
                    let datePart = '';
                    datePart += sada.getFullYear().toString();
                    datePart += (sada.getMonth() + 1).toString();
                    datePart += sada.getDate().toString();

                    let randomPart: string =
                        new Array(10)
                            .fill(0)
                            .map(e => (Math.random() * 9).toFixed(0).toString())
                            .join('');

                    let fileName = datePart + '-' + randomPart + '-' + normalized;
                    fileName = fileName.toLocaleLowerCase();

                    callback(null, fileName);
                }
            }),
            fileFilter: (req, file, callback) => {
                // 1. Check ekstenzije: JPG, PNG
                if (!file.originalname.toLowerCase().match(/\.(jpg|png)$/)) {
                    req.fileFilterError = 'Bad file extension!';
                    callback(null, false);
                    return;
                }

                // 2. Check tipa sadrzaja: image/jpeg, image/png (mimetype)
                if (!(file.mimetype.includes('jpeg') || file.mimetype.includes('png'))) {
                    req.fileFilterError = 'Bad file content type!';
                    callback(null, false);
                    return;
                }

                callback(null, true);
            },
            limits: {
                files: 1,
                fileSize: StorageConfig.photo.maxSize,
            },
        })
    )
    async uploadPhoto(
        @Param('id') articleId: number,
        @UploadedFile() photo,
        @Req() req
    ): Promise<ApiResponse | Photo> {
        if (req.fileFilterError) {
            return new ApiResponse('error', -4002, req.fileFilterError);
        }

        if (!photo) {
            return new ApiResponse('error', -4002, 'File not uploaded!');
        }

        const fileTypeResult = await fileType.fromFile(photo.path);
        if (!fileTypeResult) {
            fs.unlinkSync(photo.path);
            return new ApiResponse('error', -4002, 'Cannot detect file type!');
        }

        const realMimeType = fileTypeResult.mime;
        if (!(realMimeType.includes('jpeg') || realMimeType.includes('png'))) {
            fs.unlinkSync(photo.path);
            return new ApiResponse('error', -4002, 'Bad file content type!');
        }

        await this.createResizedImage(photo, StorageConfig.photo.resize.thumb);
        await this.createResizedImage(photo, StorageConfig.photo.resize.small);

        const newPhoto: Photo = new Photo();
        newPhoto.articleId = articleId;
        newPhoto.imagePath = photo.filename;

        const savedPhoto = await this.photoService.add(newPhoto);
        if (!savedPhoto) {
            return new ApiResponse('error', -4001);
        }

        return savedPhoto;
    }

    async createResizedImage(photo, resizeSettings) {
        const originalFilePath = photo.path;
        const fileName = photo.filename;

        const destinationFilePath =
            StorageConfig.photo.destination +
            resizeSettings.directory +
            fileName;

        await sharp(originalFilePath)
            .resize({
                fit: 'cover',
                width: resizeSettings.width,
                height: resizeSettings.height,
            })
            .toFile(destinationFilePath);
    }

    @Delete(':articleId/deletePhoto/:photoId')
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator')
    public async deletePhoto(@Param('articleId') articleId:number,
                             @Param('photoId') photoId:number,
                             ){
                                const photo = await this.photoService.findOne({
                                    where:{ articleId: articleId,
                                            photoId:photoId}
                                    
                                });

                                if(!photo){
                                    return new ApiResponse('error',-4004,'Photo not found!');
                                }
                                try{
                                    fs.unlinkSync(StorageConfig.photo.destination +photo.imagePath);
                                fs.unlinkSync(StorageConfig.photo.destination + 
                                              StorageConfig.photo.resize.thumb.directory +
                                              photo.imagePath);
                                fs.unlinkSync(StorageConfig.photo.destination +
                                              StorageConfig.photo.resize.small.directory+photo.imagePath)
                                }catch(e){}
                                
                                
                                const deleteResult = await this.photoService.deleteById(photoId);

                                if(deleteResult.affected ===0){
                                    return new ApiResponse('error',-4004,'Photo not found!');
                                }

                                return new ApiResponse('ok', 0, 'One photo deleted.');

                             }

                             @Post('search')
                             @UseGuards(RoleCheckedGuard)
                             @AllowToRoles('administrator', 'user')
                             async search(@Body() data: ArticleSearchDto): Promise<Article[] | ApiResponse> {
                                 return await this.service.search(data);
                             }
                             
}


