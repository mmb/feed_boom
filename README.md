[![Build Status](https://travis-ci.org/mmb/feed_boom.png)](https://travis-ci.org/mmb/feed_boom)
[![Code Climate](https://codeclimate.com/github/mmb/feed_boom.png)](https://codeclimate.com/github/mmb/feed_boom)

A rails app that is an instant Atom feed service.

Makes it as easy as possible to create and populate hosted feeds.

Uses:

* a gateway to services that consume Atom (such as [IFTTT](https://ifttt.com/))

* an easy way to republish data from other services into an Atom feed

* development and testing of feed consuming software

API:

```sh
# All parameters
$ curl -d title=test -d link=http://test.com/ -d author=a -d content='test content' http://localhost:3000/feeds/test

# Minimum parameters
$ curl -d link=http://test2.com/  http://localhost:3000/feeds/test

$ curl http://localhost:3000/feeds/test
```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<feed xml:lang="en-US" xmlns="http://www.w3.org/2005/Atom">
  <id>tag:localhost,2005:/feeds/test</id>
  <link rel="alternate" type="text/html" href="http://localhost:3000"/>
  <link rel="self" type="application/atom+xml" href="http://localhost:3000/feeds/test"/>
  <title>test</title>
  <updated>2013-08-14T06:54:15Z</updated>
  <entry>
    <id>tag:localhost,2005:FeedItem/2</id>
    <published>2013-08-14T06:54:15Z</published>
    <updated>2013-08-14T06:54:15Z</updated>
    <link rel="alternate" type="text/html" href="http://test2.com/"/>
    <title/>
    <author>
      <name/>
    </author>
    <content/>
  </entry>
  <entry>
    <id>tag:localhost,2005:FeedItem/1</id>
    <published>2013-08-14T06:54:03Z</published>
    <updated>2013-08-14T06:54:03Z</updated>
    <link rel="alternate" type="text/html" href="http://test.com/"/>
    <title>test</title>
    <author>
      <name>a</name>
    </author>
    <content>test content</content>
  </entry>
</feed>
```
