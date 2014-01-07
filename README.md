PWStrength
=============

PWStrength is a simple validator for checking password strength.

```objc
PWSResult result = [PWStrength validateWithPassword:@"Myp@ssw0rd!"];
result.complexity; // 0.0f-1.0f
result.valid; // YES or NO
```

License
=========

MIT

