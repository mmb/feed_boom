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
# Posting with all parameters

$ curl \
-d title=test \
-d link=http://test.com/ \
-d author=a \
-d content='test content' \
http://localhost:3000/feeds/atest

# Posting with minimum parameters

$ curl \
-d link=http://test2.com/ \
http://localhost:3000/feeds/atest

# Setting a write password on a new feed (username doesn't matter).

$ curl \
-u :secret \
-d link=http://test3.com/ \
http://localhost:3000/feeds/btest

$ curl http://localhost:3000/feeds/atest.atom
```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<feed xml:lang="en-US" xmlns="http://www.w3.org/2005/Atom">
  <id>tag:localhost,2005:/feeds/atest</id>
  <link rel="alternate" type="text/html" href="http://localhost:3000"/>
  <link rel="self" type="application/atom+xml" href="http://localhost:3000/feeds/atest.atom"/>
  <title>atest</title>
  <updated>2013-08-30T07:21:35Z</updated>
  <entry>
    <id>tag:localhost,2005:FeedItem/22</id>
    <published>2013-08-30T07:21:35Z</published>
    <updated>2013-08-30T07:21:35Z</updated>
    <link rel="alternate" type="text/html" href="http://test2.com/"/>
    <title/>
    <author>
      <name/>
    </author>
    <content/>
  </entry>
  <entry>
    <id>tag:localhost,2005:FeedItem/21</id>
    <published>2013-08-30T07:21:18Z</published>
    <updated>2013-08-30T07:21:18Z</updated>
    <link rel="alternate" type="text/html" href="http://test.com/"/>
    <title>test</title>
    <author>
      <name>a</name>
    </author>
    <content>test content</content>
  </entry>
</feed>
```
