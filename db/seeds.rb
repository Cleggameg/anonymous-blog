entry = Entry.create(content: "Hey boy hey")
tag1 = Tag.create(description: "boy")
tag2 = Tag.create(description: "hey")
tagging = entry.taggings.create(tag_id: tag1.id)
tagging = entry.taggings.create(tag_id: tag2.id)
