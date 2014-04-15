//
//  ContactListener.h
//  Breakout
//
//  Created by Matthew Newell on 2014-04-06.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

#import <Box2D/Box2D.h>
#import <vector>
#import <algorithm>

struct Contact {
    b2Fixture *fixtureA;
    b2Fixture *fixtureB;
    bool operator==(const Contact& other) const
    {
        return (fixtureA == other.fixtureA) && (fixtureB == other.fixtureB);
    }
};

class KMContactListener : public b2ContactListener {
    
public:
    std::vector<Contact>_contacts;
    
    KMContactListener();
    ~KMContactListener();
    
    virtual void BeginContact(b2Contact* contact);
    virtual void EndContact(b2Contact* contact);
    virtual void PreSolve(b2Contact* contact, const b2Manifold* oldManifold);
    virtual void PostSolve(b2Contact* contact, const b2ContactImpulse* impulse);
    
};