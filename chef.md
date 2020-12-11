## Notes

```
Chef::Exceptions::ImmutableAttributeModification: Node attributes are read-only when you do not specify which precedence level to set. To set an attribute use code like   `node.default["key"] = "value"'
```

===>

```
node['cookbook_name']['attribute_name'] = 'abc'
# change to:
node.default['cookbook_name']['attribute_name'] = 'abc'
```

## Misc

attributes are defined by

    * the state of the node itself
    * cookbooks in attribute files and recipes
    * roles
    * environments

run lists specify what recipes the node should run, along with the order in which they should run.


