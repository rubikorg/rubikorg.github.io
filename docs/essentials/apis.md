# APIs
<br/>

## Templating

The Rubik APIs for using Go's templating engine which makes it easier for creating REST APIs.

#### Render
`type: Function`

Render returns a mixin holding the data to be rendered on the web page or sent over the wire.
```go
import r "github.com/rubikorg/rubik"

func myCtl(en interface{}) r.ByteResponse {
	return r.Render(r.Type.HTML, en, "mypage.html")
}
```
<br/>
## Storage Container
`type: Struct`

StorageContainer is abstracted struct to access your storage files. It can access of remove
a whole container. Container corresponds to a single directory in your storage folder and will
have access to files only inside this container/directory.

#### GetStorageContainers
`type: Function`

GetStorageContainers returns the names of containers present in your storage/ folder. You can
access them by calling `Storage.Access` API and use Get or Put to work with your files.

```go
import r "github.com/rubikorg/rubik"

containers := r.GetStorageContainers()
for _, name := range containers {
	// do something with these containers
}

```

#### Access
`type: Function`

Access a FileStore from your StorageContainer. It can be viewed as accessing a specific folder
inside your storage/ folder and performing operations inside of that folder.

```go
fileStore, err := r.Storage.Access("paymentFiles")
if err != nil {
	// cannot access this container
}
```

#### Remove
`type: Function`

Remove a FileStore from your StorageContainer. Removing a FileStore will remove all the files
inside the FileStore.

```go
err := r.Storage.Remove("paymentFiles")
if err != nil {
	// error occured while deleting container
}
```

## FileStore
`type: Struct`

FileStore lets you perform CRUD on files of StorageContainer. FileStore returns the name of
container you are accessing by Name field.

#### Has
`type: Function`

Has checks if the file by given name is present inside this FileStore.
```go
if fileStore.Has("file.txt") {
	// do something
}
```

#### Get
`type: Function`

Get a file from this FileStore, returs byte slice.
```go
fileContents := fileStore.Get("file.txt")
if fileContents == nil {
	// did not find file
}
```

#### Put
`type: Function`

Put a file inside this FileStore given the content as parameter.
```go
err := fileStore.Put("file.txt", contents)
if err != nil {
	// error occured while writing to disk
}
```

#### Delete
`type: Function`

Delete a file from the FileStore, returns error.
```go
err := fileStore.Delete("file.txt")
if err != nil {
	// error occured while deleting
}
```

