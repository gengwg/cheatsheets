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

