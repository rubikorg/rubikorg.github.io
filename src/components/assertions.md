# 🔍 Assertions

Assertions are used to validate and confirm that a value from the client/user is of the right type
and meets the requirements of your business needs. E.g: `email` value inside body must be of the
form of an email id and not any other type or structure.

> **Note:**
>
> When assertions fail it responds with `400 (Bad Request)` with the assertion message provided by
> you.

### Assertion type:

```go
type Assertion func (interface{}) error
```

### Writing your own assertions:

Let's write a simple assertion to check if the integer value equates to 0 or not:

```go
func isZero(val interface{}) error {
	msg := "$ does not equates to 0."
	switch val.(type) {
		case string:
			intval, err := strconv.Atoi(val)
			if err != nil {
				return errors.New("$ is not an integer value")
			}

			if intval != 0 {
				return errors.New(msg)
			}
			return nil
		case int:
			val != 0 {
				return errors.New(msg)
			}
			return nil
		default:
			return nil
	}
}
```

**Notice** the `$` symbol, this is used to populate the name of the variable it is checking. As per
the above example if the `Threshold` cannot be converted to an integer the error message will be
`Threshold is not an integer value`.

### Using your assertion:

```go
type AddEn {
	Food 	string
	Threshold 	int
}

var addRoute = rubik.Route{
	Path: "/add",
	Entity: AddEn{},
	Validations: rubik.Validation{
		"Threshold": []rubik.Assertion{isZero},
	},
	Controller: addCtl,
}
```
