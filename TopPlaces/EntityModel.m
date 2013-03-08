//
//  TableModel.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-03-09.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "EntityModel.h"
#import "Entity.h"

@implementation EntityModel
-(NSString *)cellTitleFor:(id)selectedObject {
    Entity *ent = (Entity *)selectedObject;
    return ent.title;
}

-(NSString *)cellDescriptionFor:(id)selectedObject {
    Entity *ent = (Entity *)selectedObject;
    return ent.subtitle;
}


@end
