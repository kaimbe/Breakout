//
//  KMContactListener.mm
//  Breakout
//
//  Created by Matthew Newell on 2014-04-06.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

#import "KMContactListener.h"


KMContactListener::KMContactListener() : _contacts() {
}

KMContactListener::~KMContactListener() {
}

void KMContactListener::BeginContact(b2Contact* contact) {
    // We need to copy out the data because the b2Contact passed in
    // is reused.
    Contact myContact = { contact->GetFixtureA(), contact->GetFixtureB() };
    _contacts.push_back(myContact);
}

void KMContactListener::EndContact(b2Contact* contact) {
    Contact myContact = { contact->GetFixtureA(), contact->GetFixtureB() };
    std::vector<Contact>::iterator pos;
    pos = std::find(_contacts.begin(), _contacts.end(), myContact);
    if (pos != _contacts.end()) {
        _contacts.erase(pos);
    }
}

void KMContactListener::PreSolve(b2Contact* contact, const b2Manifold* oldManifold) {
}

void KMContactListener::PostSolve(b2Contact* contact, const b2ContactImpulse* impulse) {
}