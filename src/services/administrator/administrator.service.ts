import { Injectable, Param } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Administrator } from 'entities/administrator.entity';
import { AddAdministratorDto } from 'src/dtos/administrator/add.administrator.dto';
import { Admin, Any, Repository } from 'typeorm';
import * as crypto from "crypto";
import { EditAdministratorDto } from 'src/dtos/administrator/edit.administrator.dto';

@Injectable()
export class AdministratorService {
    constructor(
        @InjectRepository(Administrator) 
        private readonly administrator:Repository<Administrator>
    ){}

    getAll():Promise<Administrator[]>{
        return this.administrator.find();
    }


    getById(administratorId: number): Promise<Administrator> { 
        return this.administrator.findOneBy({administratorId});
    }


    add(data:AddAdministratorDto){
        const crypto = require('crypto')
        const passwordHash = crypto.createHash('sha512');
        passwordHash.update(data.password);

        const passwordHashString = passwordHash.digest('hex').toUpperCase();

        let newAdmin:Administrator = new Administrator();
        newAdmin.username = data.username;
        newAdmin.passwordHash = passwordHashString;

        return this.administrator.save(newAdmin);

    }

    async editById(administratorId:number, data:EditAdministratorDto):Promise<Administrator>{
        let admin:Administrator = await this.administrator.findOneBy({administratorId});
        
        const crypto = require('crypto')
        const passwordHash = crypto.createHash('sha512');
        passwordHash.update(data.password);

        const passwordHashString = passwordHash.digest('hex').toUpperCase();

        admin.passwordHash = passwordHashString;

        return this.administrator.save(admin);
    
    }


}