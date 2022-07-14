import { Injectable, Param } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Administrator } from 'src/entities/administrator.entity';
import { AddAdministratorDto } from 'src/dtos/administrator/add.administrator.dto';
import { Admin, Any, Repository } from 'typeorm';
import * as crypto from "crypto";
import { EditAdministratorDto } from 'src/dtos/administrator/edit.administrator.dto';
import { ApiResponse } from 'src/misc/api.response.class';

@Injectable()
export class AdministratorService {
    constructor(
        @InjectRepository(Administrator) 
        private readonly administrator:Repository<Administrator>
    ){}

    getAll():Promise<Administrator[]>{
        return this.administrator.find();
    }


    getById(administratorId: number): Promise<Administrator|ApiResponse> { 
        return this.administrator.findOneBy({administratorId});
    }

    async getByUsername(username:string):Promise<Administrator | null>{
        const admin = await this.administrator.findOneBy({
            username:username
        });

        if(admin) {
            return admin;
        }

        return null;
    }


    add(data:AddAdministratorDto):Promise<Administrator | ApiResponse>{
        const crypto = require('crypto')
        const passwordHash = crypto.createHash('sha512');
        passwordHash.update(data.password);

        const passwordHashString = passwordHash.digest('hex').toUpperCase();

        let newAdmin:Administrator = new Administrator();
        newAdmin.username = data.username;
        newAdmin.passwordHash = passwordHashString;

        return new Promise((resolve)=>{
            this.administrator.save(newAdmin)
            .then(data => resolve(data))
            .catch(error=>{
                const response:ApiResponse = new ApiResponse("error", -1001);
                resolve(response);
            })
        })

    }

    async editById(administratorId:number, data:EditAdministratorDto):Promise<Administrator | ApiResponse>{
        let admin:Administrator = await this.administrator.findOneBy({administratorId});
        
        if(admin === null){
            return new Promise((resolve) =>{
                resolve(new ApiResponse("error", -1002));
            });
        }
        const crypto = require('crypto')
        const passwordHash = crypto.createHash('sha512');
        passwordHash.update(data.password);

        const passwordHashString = passwordHash.digest('hex').toUpperCase();

        admin.passwordHash = passwordHashString;

        return this.administrator.save(admin);
    
    }


}