test_xml_parser = {}
  function test_xml_parser:setUp()
    -- Set up and prepare here
  end
  
  function test_xml_parser:test_code_inspected()
    assertEquals(1,1)
  end
  
  --reading xml file and print category and the picture of the category -- works during the test
  function test_xml_parser:test_read_xml()
    local filename = "src/data/rss/world.xml"
    local category = "world"
    local test = xml_parser.read_xml(filename, category)
    assertNotNil(test)
  end
  
  function test_xml_parser:tearDown()
    -- Clean up here
  end
