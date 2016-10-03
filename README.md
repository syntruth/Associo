# Associo

This is a fork and rework of John Nunemaker's original [Joint](https://github.com/jnunemaker/joint) plugin for
MongoMapper. To quote his original README:

> MongoMapper and GridFS joined in file upload love.

## Usage

Declare the plugin and use the attachment method to make attachments.

```ruby
class Foo
  include MongoMapper::Document
  plugin Associo

  attachment :image
  attachment :pdf
end
```

This gives you #image, #image=, #pdf, and #pdf=. The = methods take any IO that responds to read (File, Tempfile, etc). The image and pdf methods return a GridIO instance (can be found in the ruby driver).

Also, #image and #pdf are proxies so you can do stuff like:

    doc.image.id
    doc.image.size
    doc.image.type
    doc.image.name

If you call a method other than those in the proxy it calls it on the GridIO instance so you can still get at all the GridIO instance methods.

## Setting GridFS Chunk Size

You can set the `chunkSize` value of the GridFS file by passing in the option to the `attachment` call. This size is in bytes, and will default to the MongoDB default of 255k.

```ruby
class Foo
  include MongoMapper::Document
  plugin Associo
  
  attachment :file, chunk_size: 2097152
end
```

## TODO
* Rework the tests so that they pass again.
* Rubocop/clean up the code.
* Maybe refactor a few things to make understanding the plugin just a bit easier. (Not that it's hard. :D)

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 John Nunemaker. See LICENSE for details.  
Copyright (c) 2016 Randy Carnahan. See LICENSE for details.
