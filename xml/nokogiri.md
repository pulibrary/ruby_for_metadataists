# XML Processing with Nokogiri
```
require "nokogiri"
```

## Parse an XML file
```
xml_file = ARGV[0]
xml = Nokogiri::XML(File.read(xml_file))
```

## Navigate an XML document with XPath
```
ns = { ead: "urn:isbn:1-931666-22-9", xlink: "http://www.w3.org/1999/xlink" }
ark_url = xml.xpath("//ead:eadid/@url", ns).to_s
```

## Relative XPath expressions
```
c = xml.xpath("//ead:c", ns).first
extent = c.xpath("./ead:did/ead:physdesc/ead:extent/text()", ns)

xml.xpath("//ead:c", ns).each do |c|
  extent = c.xpath("./ead:did/ead:physdesc/ead:extent/text()", ns)
end
``` 

## Adding attributes and elements
```
element = xml.at_xpath("./ead:did", ns)
dao = Nokogiri::XML::Element.new("dao", xml)
dao.set_attribute("xlink:type", "simple")
element.add_child(dao)
```

## Removing attributes and elements
```
dao.attribute_nodes.first.remove # remove first
dao.attribute_nodes.each(&:remove) # remove all
dao.remove # remove from parent
```

## Warning
If you try to do nonsensical things (like add a parent node to a child), it may blow up.

# XSLT (1.0 only)
```
xsl = Nokogiri::XSLT(File.read("template.xsl"))
output = xsl.transform(xml)
```
