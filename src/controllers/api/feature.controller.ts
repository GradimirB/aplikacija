import { Controller, UseGuards} from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { Feature } from "src/entities/feature.entity";
import { features } from "process";
import { FeatureService } from "src/services/feature/feature.service";
import { RoleCheckedGuard } from "src/misc/role.checker.guard";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";
import { User } from "src/entities/user.entity";

@Controller('api/feature')
@Crud({
    model:{
        type:Feature
    },
    params:{
        id:{
            field:'featureId',
            type:'number',
            primary:true
        }
    },
    query:{
        join:{
            category:{
                eager:true
            },
            articleFeatures:{
                eager:false
            },
            articles:{
                eager:false
            }
        }
    },  
    routes:{
        only:[
            "createOneBase",
            "createManyBase",
            "getManyBase",
            "getOneBase",
            "updateOneBase",
        ],
        createOneBase:{
            decorators:[
                UseGuards(RoleCheckedGuard),
                AllowToRoles('administrator'),
            ]
        },
        createManyBase:{
            decorators:[
                UseGuards(RoleCheckedGuard),
                AllowToRoles('administrator'),
            ],
        },
        getManyBase:{
            decorators:[
                UseGuards(RoleCheckedGuard),
                AllowToRoles('administrator','user'),
            ],
        },
        updateOneBase:{
            decorators:[
                UseGuards(RoleCheckedGuard),
                AllowToRoles('administrator'),
            ],
        },
        getOneBase:{
            decorators:[
                UseGuards(RoleCheckedGuard),
                AllowToRoles('administrator','user'),
            ],
        }
    }
})
export class FeatureController{
    constructor(public service:FeatureService){

    }
}