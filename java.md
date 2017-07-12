### install on centos 7
Download rpm from:  
http://www.oracle.com/technetwork/java/javase/downloads/index.html  
then,  
`yum localinstall jdk-8u101-linux-x64.rpm`

### Decoding JSON String

```java
String myData = null;
try {
    JSONObject jsonObject = new JSONObject(jsonString);
    myData = jsonObject.getString("data");

} catch (JSONException e1) {
    // TODO Auto-generated catch block
    e1.printStackTrace();
}

// use myData.
```

## CONTROLLING THE NUMBER OF DECIMALS WHEN PRINTING A FLOAT

If value is a float number, the command String.value( "%.2f", value ) returns a string where the value is rounded to contain 2 decimals. The number between dot and f defines the amount of decimals shown.
```java
System.out.println(matti.getName() + ", body mass index: " + String.format( "%.2f", matti.bodyMassIndex()));
System.out.println(john.getName() + ", body mass index: " + String.format( "%.2f", john.bodyMassIndex()));
```

The output is:
```java
Matti,  body mass index: 26,54
John,  body mass index: 20,90
```

Integer variable value can be turned into a string by prefixing it with an empty string: "" + value.
