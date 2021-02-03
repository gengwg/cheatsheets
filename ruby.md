## Installation

### Install on Fedora

```
sudo dnf install ruby
```

### Install Ruby 2.4.0 on CentOS 6

#### Step 1. Installing Requirements

```
# yum install gcc-c++ patch readline readline-devel zlib zlib-devel
# yum install libyaml-devel libffi-devel openssl-devel make
# yum install bzip2 autoconf automake libtool bison iconv-devel sqlite-devel
```

#### Step 2. Install RVM
```
# curl -sSL https://rvm.io/mpapis.asc | gpg --import -
# curl -L get.rvm.io | bash -s stable

# source /etc/profile.d/rvm.sh
# rvm reload
```

#### Step 3. Verify Dependencies

```
# rvm requirements run
```

#### Step 4. Install Ruby 2.4

```
# rvm install 2.4.0
```

#### Step 5. Setup Default Ruby Version

```
# rvm list
# rvm use 2.4.0 --default
# ruby --version
```

## Notes

`select` method of `Arry` uses blocks to choose values that satisfy ocnditions from contents.

```
irb(main):014:1* ary = ary.select do |i|
irb(main):015:1*   i%2 == 0
irb(main):016:0> end
irb(main):017:0> ary
=> [2, 4]
```

### classes and methods

```ruby
class Animal
  def legs
    puts 4
  end
end

class Dog<Animal
  def bark
    puts "bow!"
  end
end

fred = Dog::new
fred.legs
fred.bark
```

### delimited string array

you can construct arrays of strings using the shortcut notation, %w.

```ruby
irb(main):002:0> %w(foo bar baz)
=> ["foo", "bar", "baz"
```

### determine whether an expression is defined

```
irb(main):001:0> foo = 42
=> 42
irb(main):002:0> defined? foo
=> "local-variable"
irb(main):003:0> defined? $_
=> "global-variable"
irb(main):004:0> defined? bar
=> nil
irb(main):006:0> defined? puts
=> "method"
irb(main):007:0> defined? puts(bar)
=> nil
irb(main):008:0> defined? unpack
=> nil
```

### module functions

```
irb(main):011:0> Math.sin(1.0)
=> 0.8414709848078965
irb(main):012:0> sin(1.0)
NoMethodError: undefined method `sin' for main:Object
Did you mean?  using
	from (irb):12
	from /usr/bin/irb:11:in `<main>'
irb(main):013:0> include Math
=> Object
irb(main):014:0> sin(1.0)
=> 0.8414709848078965
```

### singleton methods

```ruby
irb(main):037:0> a = "foo"
=> "foo"
irb(main):038:0> def a.f
irb(main):039:1>   printf "%s(%d)\n", self, self.size
irb(main):040:1> end
=> :f
irb(main):041:0> a.f
foo(3)
=> nil
```

### Hook methods

```ruby
class Foo
  def Foo::inherited(sub)
    printf "you made subclass of Foo, named %s\n", sub.name
  end
end

class Bar<Foo # you made subclass of Foo, named Bar
end
```

### BEGIN / END statement

executes when ruby interpreter starts/ends.

```ruby
BEGIN {
  puts 'hello!'
}

# code

END {
  puts('bye!')
}
```

### Word Array

If you want to create an array where each entry is a single word, you can use the %w{} syntax.
the %w{} method lets you skip the quotes and the commas.

```
days = %w{Monday Tuesday Wednesday Thursday Friday Saturday Sunday}
```

This is equivalent to creating the array with square braces:

```
days =  ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
```

```
irb(main):001:0> %w{foo bar}
=> ["foo", "bar"]
irb(main):002:0> %w(foo bar)
=> ["foo", "bar"]
irb(main):003:0> %w[foo bar]
=> ["foo", "bar"]
```

### Freeze Method

```
irb(main):001:0> CONST = "foo"
=> "foo"
irb(main):002:0> CONST << "bar"
=> "foobar"
irb(main):003:0> CONSTF = "foo".freeze
=> "foo"
irb(main):004:0> CONSTF << "bar"
Traceback (most recent call last):
        4: from /usr/bin/irb:23:in `<main>'
        3: from /usr/bin/irb:23:in `load'
        2: from /usr/share/gems/gems/irb-1.2.6/exe/irb:11:in `<top (required)>'
        1: from (irb):4
FrozenError (can't modify frozen String: "foo")
```
