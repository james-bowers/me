# Me

- Sign in and sign up users
- Manage user information (address, contact information)
- Set account types

#### Use with other services:

https://gist.github.com/james-bowers/4d80e2ba396ef51f402360dbfad64d51

# schema:

## account

_has one or more roles_

- active

## role

- account_id: binary (foreign key)
- person_id: binary (foreign key)
- permission_level: integer (defined by the business app)

## person

- first_name: string
- last_name: string
- dob: utc_datetime

## password

- person_id (unique constraint)
- salt
- hash

## email

- person_id: binary
- email: string
- verified: integer

---

## mobile

- person_id
- number: string
- verified: integer
