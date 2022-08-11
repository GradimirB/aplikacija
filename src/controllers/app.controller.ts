import { Controller, Get, Param } from '@nestjs/common';
import { Administrator } from 'src/entities/administrator.entity';
import { Cart } from 'src/entities/cart.entity';
import { Order } from 'src/entities/order.entity';
import { ApiResponse } from 'src/misc/api.response.class';
import { CartService } from 'src/services/cart/cart.service';
import { OrderService } from 'src/services/order/order.service';
import { AppService } from '../app.service';
import { AdministratorService } from '../services/administrator/administrator.service';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService,
              private administratorService:AdministratorService,
              private cartService:CartService,
              private order:OrderService) {}

  @Get()
  getHello(): string {
    return 'hellio world';
  } 

  @Get('nesto')
  getCart():Promise<Cart | null>{
    return this.cartService.getLastActiveCartByUserId(1);
  }

   



}
