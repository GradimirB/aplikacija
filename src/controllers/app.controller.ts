import { Controller, Get, Param } from '@nestjs/common';
import { Administrator } from 'src/entities/administrator.entity';
import { AppService } from '../app.service';
import { AdministratorService } from '../services/administrator/administrator.service';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService,
              private administratorService:AdministratorService) {}

  @Get()
  getHello(): string {
    return 'hellio world';
  } 

  


}
