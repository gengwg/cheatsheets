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
