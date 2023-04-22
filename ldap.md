
### Check what members an AD group has

```
$ ldapsearch -H ldaps://ldap.example.com:636 -D "EXAMPLE\\${USER%admin*}" -W -b dc=example,dc=com "(memberof=CN=jane-reports-all,OU=Automated,OU=ExamPle DL's,DC=example,DC=com)" dn | grep dn: | sort
```

Side note:

In bash, `${USER%admin*}` is a parameter expansion which returns the value of the `USER` variable with the shortest suffix removed, where the suffix matches the pattern `admin*`. Here's a breakdown of what this means:

- `${USER}` expands to the value of the `USER` variable, which is typically the current username.
- `%` is the operator that indicates the removal of a suffix.
- `admin*` is a pattern that matches any string that starts with `admin`.
- So `${USER%admin*}` removes the shortest suffix that matches the pattern `admin*` from the value of `USER`.

For example, if the value of `USER` is `johnadmin123`, then `${USER%admin*}` would return `john`. But if the value of `USER` is just `john`, then `${USER%admin*}` would return `john` because there is no suffix that matches the pattern `admin*`.

If `USER` is set to `johnadmin`, then `${USER%admin*}` will return `john`. 

Here's how the parameter expansion works in this case: 

- The value of `USER` is `johnadmin`.
- The pattern `admin*` matches the suffix `admin` at the end of `johnadmin`.
- The `%` operator removes the shortest suffix that matches the pattern `admin*` from the value of `USER`.
- Therefore, `${USER%admin*}` returns `john`.

So, in this case, the result is the same as if the value of `USER` was `johnadmin123`. The parameter expansion removes the `admin` suffix from the end of the string, leaving only `john`.

This type of parameter expansion is often used in shell scripts to manipulate strings and extract substrings based on patterns.
