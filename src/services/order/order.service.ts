import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { CartArticle } from "src/entities/cart-article.entity";
import { Cart } from "src/entities/cart.entity";
import { Order } from "src/entities/order.entity";
import { ApiResponse } from "src/misc/api.response.class";
import { Any, Entity, Repository } from "typeorm";
import { EntityListenerMetadata } from "typeorm/metadata/EntityListenerMetadata";

@Injectable()
export class OrderService {
    constructor(
        @InjectRepository(Cart) 
        private readonly cart:Repository<Cart>,

        @InjectRepository(Order) 
        private readonly order:Repository<Order>,
    ){}
/** 
    async addd(cartId:number):Promise <any>{ //OBRISATI*****
        const order = await this.order.findOne({where:{
            cartId:cartId,}});
        console.log('Order-porudzbina:',order)
        const cart = await this.cart.findOne({where:{cartId},
            relations:[
                "cartArticles", //RADI
            ]
        })
        console.log('Korpa:',cart);
         
        const newOrder:Order = new Order();
        newOrder.cartId = cartId;
        //await this.order.save(newOrder);
        const savedOrder = await this.order.save(newOrder);
        console.log('sacuvana porudzbina:',savedOrder)
        
        
    }//OBRISATI!!!
*/
    async add(cartId:number):Promise <Order| ApiResponse>{
        const order = await this.order.findOne({where:{
            cartId:cartId,}});
        console.log('eefefef',order)

        if(order){//vec postoji porudzbina za tu korpu i zbog toga eror
            return new ApiResponse("error", -7001, "An order for this cart has already been made.");
        }

        const cart = await this.cart.findOne({where:{cartId},
            relations:[
                "cartArticles",

            ]
        
        });


        if(!cart){
            return new ApiResponse('error', -7002, "No such cart found!");
        }

        if(cart.cartArticles.length === 0){ //SUMNJIVO DA LI TREBA .length
            return new ApiResponse('error', -7003, "This cart is empty");
        }

        const newOrder: Order = new Order();
        newOrder.cartId = cartId;
        const savedOrder = await this.order.save(newOrder);
        console.log('sssss',savedOrder)
        return await this.order.findOne({where:{orderId:savedOrder.orderId},
            relations:[
                "cart",
                "cart.user",
                "cart.cartArticles",
                "cart.cartArticles.article",
                "cart.cartArticles.article.category",
                "cart.cartArticles.article.articlePrices",
            ],
        })
            
            
        
    }


}
