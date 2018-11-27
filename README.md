# API

# API Documentation
## Users

### GET /v1/user/:userid
Gets the user’s profile information 

#### Body Params
None

#### Query Params
None

#### Success Response
Status 200 OK
```
{ id : <id>, username : <username>, phone_number : <phone number>  created : <date account created> }
```

#### Error Response
Status 401 Unauthorized
``` 
{ error : 'Unable to verity token' }
```

Status 404 Content Not Found
```
{ error : "user not found" }
```


### GET /v1/user/:userid/clipboards
Gets the user’s clipboards

#### Body Params
None

#### Query Params
None

#### Success Response
200 OK
```
[
    [<clipboard name>, <clipboard id>].....
]
```

#### Error Response
Status 401 Unauthorized
``` 
{ error : 'Unable to verity token' }
```

404 Content Not Found
```
{ error : "user not found" }
```


### POST /v1/user
Creates a new user

#### Body Params
    - username (required)
    - password (required)
    - phone_number (required)

#### Query Params
None

#### Success Response
200 OK
```
    { username : <username> }
```

#### Error Response
Status 401 Unauthorized
``` 
{ error : 'Unable to verity token' }
```

422 Unprocessable Entity 
```
    { error : 'invalid username' }
```
```
    { error : 'invalid password' }
```
```
    { error : 'invalid phone number' }
```

### PUT /v1/user/:userid
Updates a :userid’s profile information

#### Body Params
    - phone_number [optional]

#### Query Params
None

#### Success Response
200 OK
```
{ id : <id>, username : <username>, phone_number : <phone number>  created : <date account created> }
```

204 No Content (if nothing was created)

#### Failure Response
Status 401 Unauthorized
``` 
{ error : 'Unable to verity token' }
```



### DELETE /v1/user/:userid
Deletes a user from the database

#### Body Params
None

#### Query Params
None

#### Success Response
Status 204 No Content 
Does not return a body.

#### Failure Response
Status 401 Unauthorized
``` 
{ error : 'Unable to verity token' }
```

Status 500 Internal Server Error 
Does not return a body.


## Clipboards

### POST /v1/clipboard
Creates a new clipboard for the user

#### Body Params
    - boardname (required)
    - userid    (required)

#### Query Params
None

#### Success Response
200 OK
```
    { board_name : <boardname>, user_id: <userid> created_on : <created_on>, id : <board id>}
```

#### Error Response
Status 401 Unauthorized
``` 
{ error : 'Unable to verity token' }
```

422 Unprocessable Entity 
```
    { error : 'could not create new board' }
```


### PUT /v1/clipboard/:boardId
Edits the clipboard (say, the clipboard name)

#### Body Params
    - boardname (optional)

#### Query Params
None   

#### Success Response
200 OK
```
{ board_name : <boardname> }
```

204 No Content (if nothing was created)

#### Failure Response
Status 401 Unauthorized
``` 
{ error : 'Unable to verity token' }
```

Any status codes necessary here? either the resource is updated or it isn't?


#### GET /v1/clipboard/:boardId?type=mostRecent || type=all
Gets all items currently in the clipboard

#### Body Params
None

#### Query Params
    - type (mostRecent || all)

#### Success Response
200 OK
```
[
    "most recent clipboad", ...., "least recent post"
]
```

#### Error Response
Status 401 Unauthorized
``` 
{ error : 'Unable to verity token' }
```

Status 404 Content Not Found
```
{ error : "clipboard not found" }
```


### DELETE /v1/clipboard/:boardId
deletes the associated clipboard

#### Body Params
None

#### Query Params
None

#### Success Response
Status 204 No Content 
Does not return a body.

#### Failure Response
Status 401 Unauthorized
``` 
{ error : 'Unable to verity token' }
```

Status 500 Internal Server Error 
Does not return a body.


### POST /v1/clipboard/:boardid/boarditem
Adds an item to the clipboard

#### Body Params
```
{ new_item : <new_item>}
```

#### Query Params
None

#### Success Response
200 OK
```
    { new_item : <new_item> }
```

#### Error Response
Status 401 Unauthorized
``` 
{ error : 'Unable to verity token' }
```

422 Unprocessable Entity
```
    { error : 'could not create new board item' }
```


### GET /v1/boarditem/:itemID
Gets the item associated with itemID

#### Body Params
None

#### Query Params
None

#### Success Response
200 OK
```
    { itemid : <itemid>, boarditem : <boarditem>}
```

#### Error Response
Status 401 Unauthorized
``` 
{ error : 'Unable to verity token' }
```

404 Content Not Found
```
{ error : "boarditem not found" }
```

### DELETE /v1/boarditem/:itemID
Removes the board item associated with itemID

#### Body Params
None

#### Query Params
None

#### Success Response
Status 204 No Content 
Does not return a body.

#### Failure Response
Status 401 Unauthorized
``` 
{ error : 'Unable to verity token' }
```

Status 500 Internal Server Error 
Does not return a body.