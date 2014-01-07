PWStrength
=============

PWStrength is a simple validator for checking password strength.

![](https://raw.github.com/laiso/PWStrength/master/Documents/demo.gif)

```objc
PWSResult result = [PWStrength validateWithPassword:@"Myp@ssw0rd!"];
result.complexity; // 0.0f-1.0f
result.valid; // YES or NO
```

Install
==========

```ruby
pod 'PWStrength', :git => 'https://github.com/laiso/PWStrength.git'
```


License
=========

MIT

