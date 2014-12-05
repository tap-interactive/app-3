--[[ 
Author: Philippe Fremy <phil@freehackers.org>
License: BSD License, see LICENSE.txt

]]--

-- This is a bit tricky since the test uses the features that it tests.

Mock = {
    __class__ = 'Mock',
    calls = {}    
}

function Mock:new()
    local t = {}
    t.__class__ = 'Mock'
    t.calls = {}

    function t.callRecorder( callInfo )
        -- Return a function that stores its arguments in callInfo
        function f( ... )
            -- Not lua 5.0 compliant:
            args ={...}
            for i,v in pairs(args) do
                table.insert( callInfo, v )
            end
        end
        return f
    end

    local t_MT = {}
    function t_MT.__index( t, key ) 
        local callInfo = { key }
        table.insert( t.calls, callInfo )
        return t.callRecorder( callInfo )
    end

    setmetatable( t, t_MT )
    return t 
end

--our funktion

function highlight(position)
  local x_cord
  local y_cord
 -- local img

  if position == 1 or position == 4 or position == 7 then
    x_cord =260
  elseif position == 2 or position == 5 or position == 8 then
    x_cord =548
  elseif position == 3 or position == 6 or position == 9 then
    x_cord =840
  else
    error()
  end 

  if position == 1 or position == 2 or position == 3 then
    y_cord =60
    --img = highlight_green
  elseif position == 4 or position == 5 or position == 6 then
    y_cord =268
   -- img = highlight_blue
  elseif position == 7 or position == 8 or position == 9 then
    y_cord =467
   -- img = highlight_pink
  else
    error()
  end 

  local src_rec = {
    x = 0, 
    y = 0, 
   -- w = img:get_width(),
   -- h = img:get_height()
  }
  local des_rec = {
    x = x_cord, 
    y = y_cord, 
   -- w = screen:get_width(),
   -- h = screen:get_height()
  }
  --screen:copyfrom(background,back_src_rec,back_des_rec,false)
  --screen:copyfrom(img,src_rec,des_rec,false)
 -- gfx.update()

  current_highligt = position
  
  return current_highlight

end

-------------
TestMock = {}
    function TestMock:testMock()
        m = Mock:new()
        m.titi( 42 )
        m.toto( 33, "abc", { 21} )
        assertEquals(  m.calls[1][1], 'titi' )
        assertEquals(  m.calls[1][2], 42 )
        assertEquals( #m.calls[1], 2 )

        assertEquals(  m.calls[2][1], 'toto' )
        assertEquals(  m.calls[2][2], 33 )
        assertEquals(  m.calls[2][3], 'abc' )
        assertEquals(  m.calls[2][4][1], 21 )
        assertEquals( #m.calls[2], 4 )

        assertEquals( #m.calls, 2 )
    end

------------------------------------------------------------------
--
--                      Utility Tests              
--
------------------------------------------------------------------
--here goes utility tests codes

------------------------------------------------------------------
--
--                  Assertion Tests              
--
------------------------------------------------------------------

TestLuaUnitAssertions = {} --class

    TestLuaUnitAssertions.__class__ = 'TestLuaUnitAssertions'
    
    function TestLuaUnitAssertions:test_assertEquals()
        f = function() return true end
        g = function() return true end
        
        assertEquals( 1, 1 )
        assertEquals( "abc", "abc" )
        assertEquals( nil, nil )
        assertEquals( true, true )
        assertEquals( f, f)
        assertEquals( {1,2,3}, {1,2,3})
        assertEquals( {one=1,two=2,three=3}, {one=1,two=2,three=3})
        assertEquals( {one=1,two=2,three=3}, {two=2,three=3,one=1})
        assertEquals( {one=1,two={1,2},three=3}, {two={1,2},three=3,one=1})
        assertEquals( {one=1,two={1,{2,nil}},three=3}, {two={1,{2,nil}},three=3,one=1})
        assertEquals( {nil}, {nil} )

        assertError( assertEquals, 1, 2)
        assertError( assertEquals, 1, "abc" )
        assertError( assertEquals, 0, nil )
        assertError( assertEquals, false, nil )
        assertError( assertEquals, true, 1 )
        assertError( assertEquals, f, 1 )
        assertError( assertEquals, f, g )
        assertError( assertEquals, {1,2,3}, {2,1,3} )
        assertError( assertEquals, {1,2,3}, nil )
        assertError( assertEquals, {1,2,3}, 1 )
        assertError( assertEquals, {1,2,3}, true )
        assertError( assertEquals, {1,2,3}, {one=1,two=2,three=3} )
        assertError( assertEquals, {1,2,3}, {one=1,two=2,three=3,four=4} )
        assertError( assertEquals, {one=1,two=2,three=3}, {2,1,3} )
        assertError( assertEquals, {one=1,two=2,three=3}, nil )
        assertError( assertEquals, {one=1,two=2,three=3}, 1 )
        assertError( assertEquals, {one=1,two=2,three=3}, true )
        assertError( assertEquals, {one=1,two=2,three=3}, {1,2,3} )
        assertError( assertEquals, {one=1,two={1,2},three=3}, {two={2,1},three=3,one=1})
    end

    function TestLuaUnitAssertions:test_assertAlmostEquals()
        assertAlmostEquals( 1, 1, 0.1 )

        assertAlmostEquals( 1, 1.1, 0.2 )
        assertAlmostEquals( -1, -1.1, 0.2 )
        assertAlmostEquals( 0.1, -0.1, 0.3 )

        assertAlmostEquals( 1, 1.1, 0.1 )
        assertAlmostEquals( -1, -1.1, 0.1 )
        assertAlmostEquals( 0.1, -0.1, 0.2 )

        assertError( assertAlmostEquals, 1, 1.11, 0.1 )
        assertError( assertAlmostEquals, -1, -1.11, 0.1 )
        assertError( assertAlmostEquals, -1, 1, nil )
        assertError( assertAlmostEquals, -1, nil, 0 )
        assertError( assertAlmostEquals, 1, 1.1, 0 )
        assertError( assertAlmostEquals, 1, 1.1, -0.1 )
    end

    function TestLuaUnitAssertions:test_assertNotEquals()
        f = function() return true end
        g = function() return true end

        assertNotEquals( 1, 2 )
        assertNotEquals( "abc", 2 )
        assertNotEquals( "abc", "def" )
        assertNotEquals( 1, 2)
        assertNotEquals( 1, "abc" )
        assertNotEquals( 0, nil )
        assertNotEquals( false, nil )
        assertNotEquals( true, 1 )
        assertNotEquals( f, 1 )
        assertNotEquals( f, g )
        assertNotEquals( {one=1,two=2,three=3}, true )
        assertNotEquals( {one=1,two={1,2},three=3}, {two={2,1},three=3,one=1} )

        assertError( assertNotEquals, 1, 1)
        assertError( assertNotEquals, "abc", "abc" )
        assertError( assertNotEquals, nil, nil )
        assertError( assertNotEquals, true, true )
        assertError( assertNotEquals, f, f)
        assertError( assertNotEquals, {one=1,two={1,{2,nil}},three=3}, {two={1,{2,nil}},three=3,one=1})
    end

    function TestLuaUnitAssertions:test_assertNotAlmostEquals()
        assertNotAlmostEquals( 1, 1.2, 0.1 )

        assertNotAlmostEquals( 1, 1.3, 0.2 )
        assertNotAlmostEquals( -1, -1.3, 0.2 )
        assertNotAlmostEquals( 0.1, -0.1, 0.1 )

        assertNotAlmostEquals( 1, 1.1, 0.09 )
        assertNotAlmostEquals( -1, -1.1, 0.09 )
        assertNotAlmostEquals( 0.1, -0.1, 0.11 )

        assertError( assertNotAlmostEquals, 1, 1.11, 0.2 )
        assertError( assertNotAlmostEquals, -1, -1.11, 0.2 )
        assertError( assertNotAlmostEquals, -1, 1, nil )
        assertError( assertNotAlmostEquals, -1, nil, 0 )
        assertError( assertNotAlmostEquals, 1, 1.1, 0 )
        assertError( assertNotAlmostEquals, 1, 1.1, -0.1 )
    end

    function TestLuaUnitAssertions:test_assertNotEqualsDifferentTypes2()
        assertNotEquals( 2, "abc" )
    end

    function TestLuaUnitAssertions:test_assertTrue()
        assertTrue(true)
        assertError( assertTrue, false)
        assertTrue(0)
        assertTrue(1)
        assertTrue("")
        assertTrue("abc")
        assertError( assertTrue, nil )
        assertTrue( function() return true end )
        assertTrue( {} )
        assertTrue( { 1 } )
    end

    function TestLuaUnitAssertions:test_assertFalse()
        assertFalse(false)
        assertError( assertFalse, true)
        assertFalse( nil )
        assertError( assertFalse, 0 )
        assertError( assertFalse, 1 )
        assertError( assertFalse, "" )
        assertError( assertFalse, "abc" )
        assertError( assertFalse, function() return true end )
        assertError( assertFalse, {} )
        assertError( assertFalse, { 1 } )
    end

    function TestLuaUnitAssertions:test_assertNil()
        assertNil(nil)
        assertError( assertTrue, false)
        assertError( assertNil, 0)
        assertError( assertNil, "")
        assertError( assertNil, "abc")
        assertError( assertNil,  function() return true end )
        assertError( assertNil,  {} )
        assertError( assertNil,  { 1 } )
    end

    function TestLuaUnitAssertions:test_assertNotNil()
        assertError( assertNotNil, nil)
        assertNotNil( false )
        assertNotNil( 0 )
        assertNotNil( "" )
        assertNotNil( "abc" )
        assertNotNil( function() return true end )
        assertNotNil( {} )
        assertNotNil( { 1 } )
    end

    function TestLuaUnitAssertions:test_assertStrContains()
        assertStrContains( 'abcdef', 'abc' )
        assertStrContains( 'abcdef', 'bcd' )
        assertStrContains( 'abcdef', 'abcdef' )
        assertStrContains( 'abc0', 0 )
        assertError( assertStrContains, 'ABCDEF', 'abc' )
        assertError( assertStrContains, '', 'abc' )
        assertStrContains( 'abcdef', '' )
        assertError( assertStrContains, 'abcdef', 'abcx' )
        assertError( assertStrContains, 'abcdef', 'abcdefg' )
        assertError( assertStrContains, 'abcdef', 0 ) 
        assertError( assertStrContains, 'abcdef', {} ) 
        assertError( assertStrContains, 'abcdef', nil ) 

        assertStrContains( 'abcdef', 'abc', false )
        assertStrContains( 'abcdef', 'abc', true )
        assertStrContains( 'abcdef', 'a.c', true )

        assertError( assertStrContains, 'abcdef', '.abc', true )
    end

    function TestLuaUnitAssertions:test_assertStrIContains()
        assertStrIContains( 'ABcdEF', 'aBc' )
        assertStrIContains( 'abCDef', 'bcd' )
        assertStrIContains( 'abcdef', 'abcDef' )
        assertError( assertStrIContains, '', 'aBc' )
        assertStrIContains( 'abcDef', '' )
        assertError( assertStrIContains, 'abcdef', 'abcx' )
        assertError( assertStrIContains, 'abcdef', 'abcdefg' )
    end

    function TestLuaUnitAssertions:test_assertNotStrContains()
        assertError( assertNotStrContains, 'abcdef', 'abc' )
        assertError( assertNotStrContains, 'abcdef', 'bcd' )
        assertError( assertNotStrContains, 'abcdef', 'abcdef' )
        assertNotStrContains( '', 'abc' )
        assertError( assertNotStrContains, 'abcdef', '' )
        assertError( assertNotStrContains, 'abc0', 0 )
        assertNotStrContains( 'abcdef', 'abcx' )
        assertNotStrContains( 'abcdef', 'abcdefg' )
        assertError( assertNotStrContains, 'abcdef', {} ) 
        assertError( assertNotStrContains, 'abcdef', nil ) 

        assertError( assertNotStrContains, 'abcdef', 'abc', false )
        assertError( assertNotStrContains, 'abcdef', 'a.c', true )
        assertNotStrContains( 'abcdef', 'a.cx', true )
    end

    function TestLuaUnitAssertions:test_assertNotStrIContains()
        assertError( assertNotStrIContains, 'aBcdef', 'abc' )
        assertError( assertNotStrIContains, 'abcdef', 'aBc' )
        assertError( assertNotStrIContains, 'abcdef', 'bcd' )
        assertError( assertNotStrIContains, 'abcdef', 'abcdef' )
        assertNotStrIContains( '', 'abc' )
        assertError( assertNotStrIContains, 'abcdef', '' )
        assertError( assertNotStrIContains, 'abc0', 0 )
        assertNotStrIContains( 'abcdef', 'abcx' )
        assertNotStrIContains( 'abcdef', 'abcdefg' )
        assertError( assertNotStrIContains, 'abcdef', {} ) 
        assertError( assertNotStrIContains, 'abcdef', nil ) 
    end

    function TestLuaUnitAssertions:test_assertStrMatches()
        assertStrMatches( 'abcdef', 'abcdef' )
        assertStrMatches( 'abcdef', '..cde.' )
        assertError( assertStrMatches, 'abcdef', '..def')
        assertError( assertStrMatches, 'abCDEf', '..cde.')
        assertStrMatches( 'abcdef', 'bcdef', 2 )
        assertStrMatches( 'abcdef', 'bcde', 2, 5 )
        assertStrMatches( 'abcdef', 'b..e', 2, 5 )
        assertStrMatches( 'abcdef', 'ab..e', nil, 5 )
        assertError( assertStrMatches, 'abcdef', '' )
        assertError( assertStrMatches, '', 'abcdef' )

        assertError( assertStrMatches, 'abcdef', 0 ) 
        assertError( assertStrMatches, 'abcdef', {} ) 
        assertError( assertStrMatches, 'abcdef', nil ) 
    end

    function TestLuaUnitAssertions:test_assertItemsEquals()
        assertItemsEquals(nil, nil)
        assertItemsEquals({},{})
        assertItemsEquals({1,2,3}, {3,1,2})
        assertItemsEquals({nil},{nil})
        assertItemsEquals({one=1,two=2,three=3}, {two=2,one=1,three=3})
        assertItemsEquals({one=1,two=2,three=3}, {a=1,b=2,c=3})
        assertItemsEquals({1,2,three=3}, {3,1,two=2})

        assertError(assertItemsEquals, {1}, {})
        assertError(assertItemsEquals, nil, {1,2,3})
        assertError(assertItemsEquals, {1,2,3}, nil)
        assertError(assertItemsEquals, {1,2,3,4}, {3,1,2})
        assertError(assertItemsEquals, {1,2,3}, {3,1,2,4})
        assertError(assertItemsEquals, {one=1,two=2,three=3,four=4}, {a=1,b=2,c=3})
        assertError(assertItemsEquals, {one=1,two=2,three=3}, {a=1,b=2,c=3,d=4})
        assertError(assertItemsEquals, {1,2,three=3}, {3,4,a=1,b=2})
        assertError(assertItemsEquals, {1,2,three=3,four=4}, {3,a=1,b=2})

        assertItemsEquals({one=1,two={1,2},three=3}, {one={1,2},two=1,three=3})
        assertItemsEquals({one=1,
                           two={1,{3,2,one=1}},
                           three=3}, 
                        {two={1,{3,2,one=1}},
                         one=1,
                         three=3})
        -- itemsEquals is not recursive:
        assertError( assertItemsEquals,{1,{2,1},3}, {3,1,{1,2}})
        assertError( assertItemsEquals,{one=1,two={1,2},three=3}, {one={2,1},two=1,three=3})
        assertError( assertItemsEquals,{one=1,two={1,{3,2,one=1}},three=3}, {two={{3,one=1,2},1},one=1,three=3})
        assertError( assertItemsEquals,{one=1,two={1,{3,2,one=1}},three=3}, {two={{3,2,one=1},1},one=1,three=3})

        assertError(assertItemsEquals, {one=1,two=2,three=3}, {two=2,one=1,three=2})
        assertError(assertItemsEquals, {one=1,two=2,three=3}, {two=2,one=1,four=4})
        assertError(assertItemsEquals, {one=1,two=2,three=3}, {two=2,one=1,three})
        assertError(assertItemsEquals, {one=1,two=2,three=3}, {two=2,one=1,nil})
        assertError(assertItemsEquals, {one=1,two=2,three=3}, {two=2,one=1})
    end

    function TestLuaUnitAssertions:test_assertIsNumber()
        assertIsNumber(1)
        assertIsNumber(1.4)
        assertError(assertIsNumber, "hi there!")
        assertError(assertIsNumber, nil)
        assertError(assertIsNumber, {})
        assertError(assertIsNumber, {1,2,3})
        assertError(assertIsNumber, {1})
        assertError(assertIsNumber, coroutine.create( function(v) local y=v+1 end ) )
        assertError(assertIsTable, true)
    end

    function TestLuaUnitAssertions:test_assertIsString()
        assertError(assertIsString, 1)
        assertError(assertIsString, 1.4)
        assertIsString("hi there!")
        assertError(assertIsString, nil)
        assertError(assertIsString, {})
        assertError(assertIsString, {1,2,3})
        assertError(assertIsString, {1})
        assertError(assertIsString, coroutine.create( function(v) local y=v+1 end ) )
        assertError(assertIsTable, true)
    end

    function TestLuaUnitAssertions:test_assertIsTable()
        assertError(assertIsTable, 1)
        assertError(assertIsTable, 1.4)
        assertError(assertIsTable, "hi there!")
        assertError(assertIsTable, nil)
        assertIsTable({})
        assertIsTable({1,2,3})
        assertIsTable({1})
        assertError(assertIsTable, true)
        assertError(assertIsTable, coroutine.create( function(v) local y=v+1 end ) )
    end

    function TestLuaUnitAssertions:test_assertIsBoolean()
        assertError(assertIsBoolean, 1)
        assertError(assertIsBoolean, 1.4)
        assertError(assertIsBoolean, "hi there!")
        assertError(assertIsBoolean, nil)
        assertError(assertIsBoolean, {})
        assertError(assertIsBoolean, {1,2,3})
        assertError(assertIsBoolean, {1})
        assertError(assertIsBoolean, coroutine.create( function(v) local y=v+1 end ) )
        assertIsBoolean(true)
        assertIsBoolean(false)
    end

    function TestLuaUnitAssertions:test_assertIsNil()
        assertError(assertIsNil, 1)
        assertError(assertIsNil, 1.4)
        assertError(assertIsNil, "hi there!")
        assertIsNil(nil)
        assertError(assertIsNil, {})
        assertError(assertIsNil, {1,2,3})
        assertError(assertIsNil, {1})
        assertError(assertIsNil, false)
        assertError(assertIsNil, coroutine.create( function(v) local y=v+1 end ) )
    end

    function TestLuaUnitAssertions:test_assertIsFunction()
        f = function() return true end

        assertError(assertIsFunction, 1)
        assertError(assertIsFunction, 1.4)
        assertError(assertIsFunction, "hi there!")
        assertError(assertIsFunction, nil)
        assertError(assertIsFunction, {})
        assertError(assertIsFunction, {1,2,3})
        assertError(assertIsFunction, {1})
        assertError(assertIsFunction, false)
        assertError(assertIsFunction, coroutine.create( function(v) local y=v+1 end ) )
        assertIsFunction(f)
    end

    function TestLuaUnitAssertions:test_assertIsCoroutine()
        assertError(assertIsCoroutine, 1)
        assertError(assertIsCoroutine, 1.4)
        assertError(assertIsCoroutine, "hi there!")
        assertError(assertIsCoroutine, nil)
        assertError(assertIsCoroutine, {})
        assertError(assertIsCoroutine, {1,2,3})
        assertError(assertIsCoroutine, {1})
        assertError(assertIsCoroutine, false)
        assertError(assertIsCoroutine, function(v) local y=v+1 end )
        assertIsCoroutine(coroutine.create( function(v) local y=v+1 end ) )
    end

    function TestLuaUnitAssertions:test_assertIsUserdata()
        assertError(assertIsUserdata, 1)
        assertError(assertIsUserdata, 1.4)
        assertError(assertIsUserdata, "hi there!")
        assertError(assertIsUserdata, nil)
        assertError(assertIsUserdata, {})
        assertError(assertIsUserdata, {1,2,3})
        assertError(assertIsUserdata, {1})
        assertError(assertIsUserdata, false)
        assertError(assertIsUserdata, function(v) local y=v+1 end )
        assertError(assertIsUserdata, coroutine.create( function(v) local y=v+1 end ) )
    end

    function TestLuaUnitAssertions:test_assertIs()
        local f = function() return true end
        local g = function() return true end
        local t1= {}
        local t2={1,2}
        local t3={1,2}
        local t4= {a=1,{1,2},day="today"}
        local s1='toto'
        local s2='toto'
        local s3='to'..'to'

        assertIs(1,1)
        assertIs(f,f)
        assertIs('toto', 'toto')
        assertIs(s1, s2)
        assertIs(s1, s3)
        assertIs(t1,t1)
        assertIs(t4,t4)

        assertError(assertIs, 1, 2)
        assertError(assertIs, 1.4, 1)
        assertError(assertIs, "hi there!", "hola")
        assertError(assertIs, nil, 1)
        assertError(assertIs, {}, {})
        assertError(assertIs, {1,2,3}, f)
        assertError(assertIs, f, g)
        assertError(assertIs, t2,t3 )
    end

    function TestLuaUnitAssertions:test_assertNotIs()
        local f = function() return true end
        local g = function() return true end
        local t1= {}
        local t2={1,2}
        local t3={1,2}
        local t4= {a=1,{1,2},day="today"}
        local s1='toto'
        local s2='toto'

        assertError( assertNotIs, 1,1 )
        assertError( assertNotIs, f,f )
        assertError( assertNotIs, t1,t1 )
        assertError( assertNotIs, t4,t4)
        assertError( assertNotIs, s1,s2 )
        assertError( assertNotIs, 'toto', 'toto' )

        assertNotIs(1, 2)
        assertNotIs(1.4, 1)
        assertNotIs("hi there!", "hola")
        assertNotIs(nil, 1)
        assertNotIs({}, {})
        assertNotIs({1,2,3}, f)
        assertNotIs(f, g)
        assertNotIs(t2,t3)
    end

    function TestLuaUnitAssertions:test_assertTableNum()
        assertEquals( 3, 3 )
        assertNotEquals( 3, 4 )
        assertEquals( {3}, {3} )
        assertNotEquals( {3}, 3 )
        assertNotEquals( {3}, {4} )
        assertEquals( {x=1}, {x=1} )
        assertNotEquals( {x=1}, {x=2} )
        assertNotEquals( {x=1}, {y=1} )
    end
    function TestLuaUnitAssertions:test_assertTableStr()
        assertEquals( '3', '3' )
        assertNotEquals( '3', '4' )
        assertEquals( {'3'}, {'3'} )
        assertNotEquals( {'3'}, '3' )
        assertNotEquals( {'3'}, {'4'} )
        assertEquals( {x='1'}, {x='1'} )
        assertNotEquals( {x='1'}, {x='2'} )
        assertNotEquals( {x='1'}, {y='1'} )
    end
    function TestLuaUnitAssertions:test_assertTableLev2()
        assertEquals( {x={'a'}}, {x={'a'}} )
        assertNotEquals( {x={'a'}}, {x={'b'}} )
        assertNotEquals( {x={'a'}}, {z={'a'}} )
        assertEquals( {{x=1}}, {{x=1}} )
        assertNotEquals( {{x=1}}, {{y=1}} )
        assertEquals( {{x='a'}}, {{x='a'}} )
        assertNotEquals( {{x='a'}}, {{x='b'}} )
    end
    function TestLuaUnitAssertions:test_assertTableList()
        assertEquals( {3,4,5}, {3,4,5} )
        assertNotEquals( {3,4,5}, {3,4,6} )
        assertNotEquals( {3,4,5}, {3,5,4} )
        assertEquals( {3,4,x=5}, {3,4,x=5} )
        assertNotEquals( {3,4,x=5}, {3,4,x=6} )
        assertNotEquals( {3,4,x=5}, {3,x=4,5} )
        assertNotEquals( {3,4,5}, {2,3,4,5} )
        assertNotEquals( {3,4,5}, {3,2,4,5} )
        assertNotEquals( {3,4,5}, {3,4,5,6} )
    end

    function TestLuaUnitAssertions:test_assertTableNil()
        assertEquals( {3,4,5}, {3,4,5} )
        assertNotEquals( {3,4,5}, {nil,3,4,5} )
        assertNotEquals( {3,4,5}, {nil,4,5} )
        assertEquals( {3,4,5}, {3,4,5,nil} ) -- lua quirk
        assertNotEquals( {3,4,5}, {3,4,nil} )
        assertNotEquals( {3,4,5}, {3,nil,5} )
        assertNotEquals( {3,4,5}, {3,4,nil,5} )
    end
    
    function TestLuaUnitAssertions:test_assertTableNilFront()
        assertEquals( {nil,4,5}, {nil,4,5} )
        assertNotEquals( {nil,4,5}, {nil,44,55} )
        assertEquals( {nil,'4','5'}, {nil,'4','5'} )
        assertNotEquals( {nil,'4','5'}, {nil,'44','55'} )
        assertEquals( {nil,{4,5}}, {nil,{4,5}} )
        assertNotEquals( {nil,{4,5}}, {nil,{44,55}} )
        assertNotEquals( {nil,{4}}, {nil,{44}} )
        assertEquals( {nil,{x=4,5}}, {nil,{x=4,5}} )
        assertEquals( {nil,{x=4,5}}, {nil,{5,x=4}} ) -- lua quirk
        assertEquals( {nil,{x=4,y=5}}, {nil,{y=5,x=4}} ) -- lua quirk
        assertNotEquals( {nil,{x=4,5}}, {nil,{y=4,5}} )
    end

    function TestLuaUnitAssertions:test_assertTableAdditions()
        assertEquals( {1,2,3}, {1,2,3} )
        assertNotEquals( {1,2,3}, {1,2,3,4} )
        assertNotEquals( {1,2,3,4}, {1,2,3} )
        assertEquals( {1,x=2,3}, {1,x=2,3} )
        assertNotEquals( {1,x=2,3}, {1,x=2,3,y=4} )
        assertNotEquals( {1,x=2,3,y=4}, {1,x=2,3} )
    end


TestLuaUnitAssertionsError = {}

    function TestLuaUnitAssertionsError:setUp()
        self.f = function ( v )
            local y = v + 1
        end
        self.f_with_error = function (v)
            local y = v + 2
            error('This is an error', 2)
        end
    end

    function TestLuaUnitAssertionsError:test_assertError()
        local x = 1

        -- f_with_error generates an error
        has_error = not pcall( self.f_with_error, x )
        assertEquals( has_error, true )

        -- f does not generate an error
        has_error = not pcall( self.f, x )
        assertEquals( has_error, false )

        -- assertError is happy with f_with_error
        assertError( self.f_with_error, x )

        -- assertError is unhappy with f
        has_error = not pcall( assertError, self.f, x )
        assertError( has_error, true )

        -- multiple arguments
        local function f_with_multi_arguments(a,b,c)
            if a == b and b == c then return end
            error("three arguments not equal")
        end

        assertError( f_with_multi_arguments, 1, 1, 3 )
        assertError( f_with_multi_arguments, 1, 3, 1 )
        assertError( f_with_multi_arguments, 3, 1, 1 )

        has_error = not pcall( assertError, f_with_multi_arguments, 1, 1, 1 )
        assertEquals( has_error, true )
    end

    function TestLuaUnitAssertionsError:test_assertErrorMsgContains()
        local x = 1
        assertError( assertErrorMsgContains, 'toto', self.f, x )
        assertErrorMsgContains( 'is an err', self.f_with_error, x )
        assertErrorMsgContains( 'This is an error', self.f_with_error, x )
        assertError( assertErrorMsgContains, ' This is an error', self.f_with_error, x )
        assertError( assertErrorMsgContains, 'This .. an error', self.f_with_error, x )
    end

    function TestLuaUnitAssertionsError:test_assertErrorMsgEquals()
        local x = 1
        assertError( assertErrorMsgEquals, 'toto', self.f, x )
        assertError( assertErrorMsgEquals, 'is an err', self.f_with_error, x )
        assertErrorMsgEquals( 'This is an error', self.f_with_error, x )
        assertError( assertErrorMsgEquals, ' This is an error', self.f_with_error, x )
        assertError( assertErrorMsgEquals, 'This .. an error', self.f_with_error, x )
    end

    function TestLuaUnitAssertionsError:test_assertErrorMsgMatches()
        local x = 1
        assertError( assertErrorMsgMatches, 'toto', self.f, x )
        assertError( assertErrorMsgMatches, 'is an err', self.f_with_error, x )
        assertErrorMsgMatches( 'This is an error', self.f_with_error, x )
        assertErrorMsgMatches( 'This is .. error', self.f_with_error, x )
        assertError( assertErrorMsgMatches, ' This is an error', self.f_with_error, x )
    end



------------------------------------------------------------------
--
--                       Error message tests
--
------------------------------------------------------------------

TestLuaUnitErrorMsg = {} --class
    TestLuaUnitErrorMsg.__class__ = 'TestLuaUnitErrorMsg'

    function TestLuaUnitErrorMsg:tearDown()
        ORDER_ACTUAL_EXPECTED = true
    end

    function TestLuaUnitErrorMsg:test_assertEqualsMsg()
        assertErrorMsgEquals( 'expected: 2, actual: 1', assertEquals, 1, 2  )
        assertErrorMsgEquals( 'expected: "exp"\nactual: "act"', assertEquals, 'act', 'exp' )
        assertErrorMsgEquals( 'expected: true, actual: false', assertEquals, false, true )
        assertErrorMsgEquals( 'expected: 1.2, actual: 1', assertEquals, 1.0, 1.2)
        assertErrorMsgEquals( 'expected: {1, 2, 3}\nactual: {3, 2, 1}', assertEquals, {3,2,1}, {1,2,3} )
        assertErrorMsgEquals( 'expected: {one=1, two=2}\nactual: {3, 2, 1}', assertEquals, {3,2,1}, {one=1,two=2} )
        assertErrorMsgEquals( 'expected: 2, actual: nil', assertEquals, nil, 2 )
    end 

    function TestLuaUnitErrorMsg:test_assertEqualsOrderReversedMsg()
        ORDER_ACTUAL_EXPECTED = false
        assertErrorMsgEquals( 'expected: 1, actual: 2', assertEquals, 1, 2  )
        assertErrorMsgEquals( 'expected: "act"\nactual: "exp"', assertEquals, 'act', 'exp' )
    end 

    function TestLuaUnitErrorMsg:test_assertAlmostEqualsMsg()
        assertErrorMsgEquals('Values are not almost equal\nExpected: 1 with margin of 0.1, received: 2', assertAlmostEquals, 2, 1, 0.1 )
    end

    function TestLuaUnitErrorMsg:test_assertAlmostEqualsOrderReversedMsg()
        ORDER_ACTUAL_EXPECTED = false
        assertErrorMsgEquals('Values are not almost equal\nExpected: 2 with margin of 0.1, received: 1', assertAlmostEquals, 2, 1, 0.1 )
    end

    function TestLuaUnitErrorMsg:test_assertNotAlmostEqualsMsg()
        assertErrorMsgEquals('Values are almost equal\nExpected: 1 with a difference above margin of 0.2, received: 1.1', assertNotAlmostEquals, 1.1, 1, 0.2 )
    end

    function TestLuaUnitErrorMsg:test_assertNotAlmostEqualsMsg()
        ORDER_ACTUAL_EXPECTED = false
        assertErrorMsgEquals('Values are almost equal\nExpected: 1.1 with a difference above margin of 0.2, received: 1', assertNotAlmostEquals, 1.1, 1, 0.2 )
    end

    function TestLuaUnitErrorMsg:test_assertNotEqualsMsg()
        assertErrorMsgEquals( 'Received the not expected value: 1', assertNotEquals, 1, 1  )
        assertErrorMsgEquals( 'Received the not expected value: {1, 2}', assertNotEquals, {1,2}, {1,2} )
        assertErrorMsgEquals( 'Received the not expected value: nil', assertNotEquals, nil, nil )
    end 

    function TestLuaUnitErrorMsg:test_assertNotEqualsOrderReversedMsg()
        ORDER_ACTUAL_EXPECTED = false
        assertErrorMsgEquals( 'Received the not expected value: 1', assertNotEquals, 1, 1  )
    end 

    function TestLuaUnitErrorMsg:test_assertTrueFalse()
        assertErrorMsgEquals( 'expected: true, actual: false', assertTrue, false )
        assertErrorMsgEquals( 'expected: true, actual: nil', assertTrue, nil )
        assertErrorMsgEquals( 'expected: false, actual: true', assertFalse, true )
        assertErrorMsgEquals( 'expected: false, actual: 0', assertFalse, 0)
        assertErrorMsgEquals( 'expected: false, actual: {}', assertFalse, {})
        assertErrorMsgEquals( 'expected: false, actual: "abc"', assertFalse, 'abc')
        assertErrorMsgContains( 'expected: false, actual: function', assertFalse, function () end )
    end 

    function TestLuaUnitErrorMsg:test_assertNil()
        assertErrorMsgEquals( 'expected: nil, actual: false', assertNil, false )
        assertErrorMsgEquals( 'expected non nil value, received nil', assertNotNil, nil )
    end

    function TestLuaUnitErrorMsg:test_assertStrContains()
        assertErrorMsgEquals( 'Error, substring "xxx" was not found in string "abcdef"', assertStrContains, 'abcdef', 'xxx' )
        assertErrorMsgEquals( 'Error, substring "aBc" was not found in string "abcdef"', assertStrContains, 'abcdef', 'aBc' )
        assertErrorMsgEquals( 'Error, substring "xxx" was not found in string ""', assertStrContains, '', 'xxx' )

        assertErrorMsgEquals( 'Error, substring "xxx" was not found in string "abcdef"', assertStrContains, 'abcdef', 'xxx', false )
        assertErrorMsgEquals( 'Error, substring "aBc" was not found in string "abcdef"', assertStrContains, 'abcdef', 'aBc', false )
        assertErrorMsgEquals( 'Error, substring "xxx" was not found in string ""', assertStrContains, '', 'xxx', false )

        assertErrorMsgEquals( 'Error, regexp "xxx" was not found in string "abcdef"', assertStrContains, 'abcdef', 'xxx', true )
        assertErrorMsgEquals( 'Error, regexp "aBc" was not found in string "abcdef"', assertStrContains, 'abcdef', 'aBc', true )
        assertErrorMsgEquals( 'Error, regexp "xxx" was not found in string ""', assertStrContains, '', 'xxx', true )

    end 

    function TestLuaUnitErrorMsg:test_assertStrIContains()
        assertErrorMsgEquals( 'Error, substring "xxx" was not found in string "abcdef"', assertStrContains, 'abcdef', 'xxx' )
        assertErrorMsgEquals( 'Error, substring "xxx" was not found in string ""', assertStrContains, '', 'xxx' )
    end 

    function TestLuaUnitErrorMsg:test_assertNotStrContains()
        assertErrorMsgEquals( 'Error, substring "abc" was found in string "abcdef"', assertNotStrContains, 'abcdef', 'abc' )
        assertErrorMsgEquals( 'Error, substring "abc" was found in string "abcdef"', assertNotStrContains, 'abcdef', 'abc', false )
        assertErrorMsgEquals( 'Error, regexp "..." was found in string "abcdef"', assertNotStrContains, 'abcdef', '...', true)
    end 

    function TestLuaUnitErrorMsg:test_assertNotStrIContains()
        assertErrorMsgEquals( 'Error, substring "aBc" was found (case insensitively) in string "abcdef"', assertNotStrIContains, 'abcdef', 'aBc' )
        assertErrorMsgEquals( 'Error, substring "abc" was found (case insensitively) in string "abcdef"', assertNotStrIContains, 'abcdef', 'abc' )
    end 

    function TestLuaUnitErrorMsg:test_assertStrMatches()
        assertErrorMsgEquals('Error, pattern "xxx" was not matched by string "abcdef"', assertStrMatches, 'abcdef', 'xxx' )
    end 

    function TestLuaUnitErrorMsg:test_assertIsNumber()
        assertErrorMsgEquals( 'Expected: a number value, actual: type string, value "abc"', assertIsNumber, 'abc' )
        assertErrorMsgEquals( 'Expected: a number value, actual: type nil, value nil', assertIsNumber, nil )
    end 

    function TestLuaUnitErrorMsg:test_assertIsString()
        assertErrorMsgEquals( 'Expected: a string value, actual: type number, value 1.2', assertIsString, 1.2 )
        assertErrorMsgEquals( 'Expected: a string value, actual: type nil, value nil', assertIsString, nil )
    end 

    function TestLuaUnitErrorMsg:test_assertIsTable()
        assertErrorMsgEquals( 'Expected: a table value, actual: type number, value 1.2', assertIsTable, 1.2 )
        assertErrorMsgEquals( 'Expected: a table value, actual: type nil, value nil', assertIsTable, nil )
    end 

    function TestLuaUnitErrorMsg:test_assertIsBoolean()
        assertErrorMsgEquals( 'Expected: a boolean value, actual: type number, value 1.2', assertIsBoolean, 1.2 )
        assertErrorMsgEquals( 'Expected: a boolean value, actual: type nil, value nil', assertIsBoolean, nil )
    end 

    function TestLuaUnitErrorMsg:test_assertIsFunction()
        assertErrorMsgEquals( 'Expected: a function value, actual: type number, value 1.2', assertIsFunction, 1.2 )
        assertErrorMsgEquals( 'Expected: a function value, actual: type nil, value nil', assertIsFunction, nil )
    end 

    function TestLuaUnitErrorMsg:test_assertIsCoroutine()
        assertErrorMsgEquals( 'Expected: a thread value, actual: type number, value 1.2', assertIsCoroutine, 1.2 )
        assertErrorMsgEquals( 'Expected: a thread value, actual: type nil, value nil', assertIsCoroutine, nil )
    end 

    function TestLuaUnitErrorMsg:test_assertIsUserdata()
        assertErrorMsgEquals( 'Expected: a userdata value, actual: type number, value 1.2', assertIsUserdata, 1.2 )
        assertErrorMsgEquals( 'Expected: a userdata value, actual: type nil, value nil', assertIsUserdata, nil )
    end 

    function TestLuaUnitErrorMsg:test_assertIs()
        assertErrorMsgEquals( 'Expected object and actual object are not the same\nExpected: 1, actual: 2', assertIs, 2, 1 )
        ORDER_ACTUAL_EXPECTED = false
        assertErrorMsgEquals( 'Expected object and actual object are not the same\nExpected: 2, actual: 1', assertIs, 2, 1 )
    end 

    function TestLuaUnitErrorMsg:test_assertNotIs()
        local v = {1,2}
        assertErrorMsgEquals( 'Expected object and actual object are the same object: {1, 2}', assertNotIs, v, v )
    end 

    function TestLuaUnitErrorMsg:test_assertItemsEquals()
        assertErrorMsgEquals('Contents of the tables are not identical:\nExpected: {one=2, two=3}\nActual: {1, 2}' , assertItemsEquals, {1,2}, {one=2, two=3} )
    end 

    function TestLuaUnitErrorMsg:test_assertError()
        assertErrorMsgEquals('Expected an error when calling function but no error generated' , assertError, function( v ) local y = v+1 end, 3 )
    end 

    function TestLuaUnitErrorMsg:test_assertErrorMsg()
        assertErrorMsgEquals('No error generated when calling function but expected error: "bla bla bla"' , assertErrorMsgEquals, 'bla bla bla', function( v ) local y = v+1 end, 3 )
        assertErrorMsgEquals('No error generated when calling function but expected error containing: "bla bla bla"' , assertErrorMsgContains, 'bla bla bla', function( v ) local y = v+1 end, 3 )
        assertErrorMsgEquals('No error generated when calling function but expected error matching: "bla bla bla"' , assertErrorMsgMatches, 'bla bla bla', function( v ) local y = v+1 end, 3 )

        assertErrorMsgEquals('Exact error message expected: "bla bla bla"\nError message received: "toto xxx"\n' , assertErrorMsgEquals, 'bla bla bla', function( v ) error('toto xxx',2) end, 3 )
        assertErrorMsgEquals('Error message does not contain: "bla bla bla"\nError message received: "toto xxx"\n' , assertErrorMsgContains, 'bla bla bla', function( v ) error('toto xxx',2) end, 3 )
        assertErrorMsgEquals('Error message does not match: "bla bla bla"\nError message received: "toto xxx"\n' , assertErrorMsgMatches, 'bla bla bla', function( v ) error('toto xxx',2) end, 3 )

    end 
------------------------------------------------------------------
--
--                       Execution Tests 
--
------------------------------------------------------------------

TestLuaUnitExecution = {} --class

    TestLuaUnitExecution.__class__ = 'TestLuaUnitExecution'

    function TestLuaUnitExecution:tearDown()
        executedTests = {}
        LuaUnit.isTestName = LuaUnit.isTestNameOld
    end

    function TestLuaUnitExecution:setUp()
        executedTests = {}
        LuaUnit.isTestNameOld = LuaUnit.isTestName
        LuaUnit.isTestName = function( s ) return (string.sub(s,1,6) == 'MyTest') end
    end

    MyTestToto1 = {} --class
        function MyTestToto1:test1() table.insert( executedTests, "MyTestToto1:test1" ) end
        function MyTestToto1:testb() table.insert( executedTests, "MyTestToto1:testb" ) end
        function MyTestToto1:test3() table.insert( executedTests, "MyTestToto1:test3" ) end
        function MyTestToto1:testa() table.insert( executedTests, "MyTestToto1:testa" ) end
        function MyTestToto1:test2() table.insert( executedTests, "MyTestToto1:test2" ) end

    MyTestToto2 = {} --class
        function MyTestToto2:test1() table.insert( executedTests, "MyTestToto2:test2" ) end

    MyTestWithFailures = {} --class
        function MyTestWithFailures:testWithFailure1() assertEquals(1, 2) end
        function MyTestWithFailures:testWithFailure2() assertError( function() end ) end
        function MyTestWithFailures:testOk() end

    MyTestOk = {} --class
        function MyTestOk:testOk1() end
        function MyTestOk:testOk2() end

    function MyTestFunction()
        table.insert( executedTests, "MyTestFunction" ) 
    end

    function TestLuaUnitExecution:test_collectTests()
        allTests = LuaUnit.collectTests()
        assertEquals( allTests, {"MyTestFunction", "MyTestOk", "MyTestToto1", "MyTestToto2","MyTestWithFailures"})
    end

    function TestLuaUnitExecution:test_MethodsAreExecutedInRightOrder()
        local runner = LuaUnit:new()
        runner:setOutputType( "NIL" )
        runner:runSuite( 'MyTestToto1' )
        assertEquals( #executedTests, 5 )
        assertEquals( executedTests[1], "MyTestToto1:test1" )
        assertEquals( executedTests[2], "MyTestToto1:test2" )
        assertEquals( executedTests[3], "MyTestToto1:test3" )
        assertEquals( executedTests[4], "MyTestToto1:testa" )
        assertEquals( executedTests[5], "MyTestToto1:testb" )
    end

    function TestLuaUnitExecution:test_runSuiteByNames()
        -- note: this also test that names are executed in explicit order
        local runner = LuaUnit:new()
        runner:setOutputType( "NIL" )
        runner:runSuiteByNames( { 'MyTestToto2', 'MyTestToto1', 'MyTestFunction' } )
        assertEquals( #executedTests, 7 )
        assertEquals( executedTests[1], "MyTestToto2:test2" )
        assertEquals( executedTests[2], "MyTestToto1:test1" )
        assertEquals( executedTests[7], "MyTestFunction" )
    end

    function TestLuaUnitExecution:testRunSomeTestByGlobalInstance( )
        assertEquals( #executedTests, 0 )
        local runner = LuaUnit:new()
        runner:setOutputType( "NIL" )
        runner:runSuiteByInstances( { { 'Toto', MyTestToto1 } }  )
        assertEquals( #executedTests, 5 )
    end

    function TestLuaUnitExecution:testRunSomeTestByLocalInstance( )
        MyLocalTestToto1 = {} --class
        function MyLocalTestToto1:test1() table.insert( executedTests, "MyLocalTestToto1:test1" ) end
        MyLocalTestToto2 = {} --class
        function MyLocalTestToto2:test1() table.insert( executedTests, "MyLocalTestToto2:test1" ) end
        function MyLocalTestToto2:test2() table.insert( executedTests, "MyLocalTestToto2:test2" ) end
        function MyLocalTestFunction() table.insert( executedTests, "MyLocalTestFunction" ) end
 
        assertEquals( #executedTests, 0 )
        local runner = LuaUnit:new()
        runner:setOutputType( "NIL" )
        runner:runSuiteByInstances( { 
            { 'MyLocalTestToto1', MyLocalTestToto1 },
            { 'MyLocalTestToto2.test2', MyLocalTestToto2 },
            { 'MyLocalTestFunction', MyLocalTestFunction },
        } )
        assertEquals( #executedTests, 3 )
        assertEquals( executedTests[1], 'MyLocalTestToto1:test1')
        assertEquals( executedTests[2], 'MyLocalTestToto2:test2')
        assertEquals( executedTests[3], 'MyLocalTestFunction')
    end

    function TestLuaUnitExecution:testRunReturnsNumberOfFailures()
        local runner = LuaUnit:new()
        runner:setOutputType( "NIL" )
        ret = runner:runSuite( 'MyTestWithFailures' )
        assertEquals(ret, 2)

        ret = runner:runSuite( 'MyTestToto1' )
        assertEquals(ret, 0)
    end

    function TestLuaUnitExecution:testTestCountAndFailCount()
        local runner = LuaUnit:new()
        runner:setOutputType( "NIL" )
        runner:runSuite( 'MyTestWithFailures' )
        assertEquals( runner.result.testCount, 3)
        assertEquals( runner.result.failureCount, 2)

        runner:runSuite( 'MyTestToto1' )
        assertEquals( runner.result.testCount, 5)
        assertEquals( runner.result.failureCount, 0)
    end

    function TestLuaUnitExecution:testRunSetupAndTeardown()
        local myExecutedTests = {}
        local MyTestWithSetupTeardown = {}
            function MyTestWithSetupTeardown:setUp()    table.insert( myExecutedTests, '1setUp' ) end
            function MyTestWithSetupTeardown:test1()    table.insert( myExecutedTests, '1test1' ) end
            function MyTestWithSetupTeardown:test2()    table.insert( myExecutedTests, '1test2' ) end
            function MyTestWithSetupTeardown:tearDown() table.insert( myExecutedTests, '1tearDown' )  end

        local MyTestWithSetupTeardown2 = {}
            function MyTestWithSetupTeardown2:setUp()    table.insert( myExecutedTests, '2setUp' ) end
            function MyTestWithSetupTeardown2:test1()    table.insert( myExecutedTests, '2test1' ) end
            function MyTestWithSetupTeardown2:tearDown() table.insert( myExecutedTests, '2tearDown' )  end

        local runner = LuaUnit:new()
        runner:setOutputType( "NIL" )
        runner:runSuiteByInstances( { { 'MyTestWithSetupTeardown.test1', MyTestWithSetupTeardown } } )
        assertEquals( runner.result.failureCount, 0 )
        assertEquals( myExecutedTests[1], '1setUp' )   
        assertEquals( myExecutedTests[2], '1test1')
        assertEquals( myExecutedTests[3], '1tearDown')
        assertEquals( #myExecutedTests, 3)

        myExecutedTests = {}
        runner:runSuiteByInstances( { 
            { 'MyTestWithSetupTeardown', MyTestWithSetupTeardown },
            { 'MyTestWithSetupTeardown2', MyTestWithSetupTeardown2 } 
        } )
        assertEquals( runner.result.failureCount, 0 )
        assertEquals( myExecutedTests[1], '1setUp' )   
        assertEquals( myExecutedTests[2], '1test1')
        assertEquals( myExecutedTests[3], '1tearDown')
        assertEquals( myExecutedTests[4], '1setUp' )   
        assertEquals( myExecutedTests[5], '1test2')
        assertEquals( myExecutedTests[6], '1tearDown')
        assertEquals( myExecutedTests[7], '2setUp' )   
        assertEquals( myExecutedTests[8], '2test1')
        assertEquals( myExecutedTests[9], '2tearDown')
        assertEquals( #myExecutedTests, 9)
    end

    function TestLuaUnitExecution:testWithSetupTeardownErrors1()
        local myExecutedTests = {}

        local MyTestWithSetupError = {}
            function MyTestWithSetupError:setUp()    table.insert( myExecutedTests, 'setUp' ); assertEquals( 'b', 'c') end
            function MyTestWithSetupError:test1()    table.insert( myExecutedTests, 'test1' ) end
            function MyTestWithSetupError:tearDown() table.insert( myExecutedTests, 'tearDown' )  end

        local runner = LuaUnit:new()
        runner:setOutputType( "NIL" )
        runner:runSuiteByInstances( { { 'MyTestWithSetupError', MyTestWithSetupError } } )
        assertEquals( runner.result.failureCount, 1 )
        assertEquals( runner.result.testCount, 1 )
        assertEquals( myExecutedTests[1], 'setUp' )   
        assertEquals( myExecutedTests[2], 'tearDown')
        assertEquals( #myExecutedTests, 2)
    end

    function TestLuaUnitExecution:testWithSetupTeardownErrors2()
        local myExecutedTests = {}

        local MyTestWithSetupError = {}
            function MyTestWithSetupError:setUp()    table.insert( myExecutedTests, 'setUp' ) end
            function MyTestWithSetupError:test1()    table.insert( myExecutedTests, 'test1' ) end
            function MyTestWithSetupError:tearDown() table.insert( myExecutedTests, 'tearDown' ); assertEquals( 'b', 'c')   end

        runner = LuaUnit:new()
        runner:setOutputType( "NIL" )
        runner:runSuiteByInstances( { { 'MyTestWithSetupError', MyTestWithSetupError } } )
        assertEquals( runner.result.failureCount, 1 )
        assertEquals( runner.result.testCount, 1 )
        assertEquals( myExecutedTests[1], 'setUp' )   
        assertEquals( myExecutedTests[2], 'test1' )   
        assertEquals( myExecutedTests[3], 'tearDown')
        assertEquals( #myExecutedTests, 3)
    end

    function TestLuaUnitExecution:testWithSetupTeardownErrors3()
        local myExecutedTests = {}

        local MyTestWithSetupError = {}
            function MyTestWithSetupError:setUp()    table.insert( myExecutedTests, 'setUp' ); assertEquals( 'b', 'c') end
            function MyTestWithSetupError:test1()    table.insert( myExecutedTests, 'test1' ) end
            function MyTestWithSetupError:tearDown() table.insert( myExecutedTests, 'tearDown' ); assertEquals( 'b', 'c')   end

        runner = LuaUnit:new()
        runner:setOutputType( "NIL" )
        runner:runSuiteByInstances( { { 'MyTestWithSetupError', MyTestWithSetupError } } )
        assertEquals( runner.result.failureCount, 1 )
        assertEquals( runner.result.testCount, 1 )
        assertEquals( myExecutedTests[1], 'setUp' )   
        assertEquals( myExecutedTests[2], 'tearDown')
        assertEquals( #myExecutedTests, 2)
    end

    function TestLuaUnitExecution:testWithSetupTeardownErrors4()
        local myExecutedTests = {}

        local MyTestWithSetupError = {}
            function MyTestWithSetupError:setUp()    table.insert( myExecutedTests, 'setUp' ); assertEquals( 'b', 'c') end
            function MyTestWithSetupError:test1()    table.insert( myExecutedTests, 'test1' ); assertEquals( 'b', 'c')  end
            function MyTestWithSetupError:tearDown() table.insert( myExecutedTests, 'tearDown' ); assertEquals( 'b', 'c')   end

        runner = LuaUnit:new()
        runner:setOutputType( "NIL" )
        runner:runSuiteByInstances( { { 'MyTestWithSetupError', MyTestWithSetupError } } )
        assertEquals( runner.result.failureCount, 1 )
        assertEquals( runner.result.testCount, 1 )
        assertEquals( myExecutedTests[1], 'setUp' )   
        assertEquals( myExecutedTests[2], 'tearDown')
        assertEquals( #myExecutedTests, 2)
    end

    function TestLuaUnitExecution:testWithSetupTeardownErrors5()
        local myExecutedTests = {}

        local MyTestWithSetupError = {}
            function MyTestWithSetupError:setUp()    table.insert( myExecutedTests, 'setUp' ) end
            function MyTestWithSetupError:test1()    table.insert( myExecutedTests, 'test1' ); assertEquals( 'b', 'c')  end
            function MyTestWithSetupError:tearDown() table.insert( myExecutedTests, 'tearDown' ); assertEquals( 'b', 'c')   end

        runner = LuaUnit:new()
        runner:setOutputType( "NIL" )
        runner:runSuiteByInstances( { { 'MyTestWithSetupError', MyTestWithSetupError } } )
        assertEquals( runner.result.failureCount, 1 )
        assertEquals( runner.result.testCount, 1 )
        assertEquals( myExecutedTests[1], 'setUp' )   
        assertEquals( myExecutedTests[2], 'test1' )   
        assertEquals( myExecutedTests[3], 'tearDown')
        assertEquals( #myExecutedTests, 3)
    end

    function TestLuaUnitExecution:testOutputInterface()
        local runner = LuaUnit:new()
        runner.outputType = Mock
        runner:runSuite( 'MyTestWithFailures', 'MyTestOk' )
        m = runner.output

        assertEquals( m.calls[1][1], 'startSuite' )
        assertEquals(#m.calls[1], 2 )

        assertEquals( m.calls[2][1], 'startClass' )
        assertEquals( m.calls[2][3], 'MyTestWithFailures' )
        assertEquals(#m.calls[2], 3 )

        assertEquals( m.calls[3][1], 'startTest' )
        assertEquals( m.calls[3][3], 'MyTestWithFailures.testOk' )
        assertEquals(#m.calls[3], 3 )

        assertEquals( m.calls[4][1], 'endTest' )
        assertEquals( m.calls[4][3], false )
        assertEquals(#m.calls[4], 3 )

        assertEquals( m.calls[5][1], 'startTest' )
        assertEquals( m.calls[5][3], 'MyTestWithFailures.testWithFailure1' )
        assertEquals(#m.calls[5], 3 )

        assertEquals( m.calls[6][1], 'addFailure' )
        assertEquals(#m.calls[6], 4 )

        assertEquals( m.calls[7][1], 'endTest' )
        assertEquals( m.calls[7][3], true )
        assertEquals(#m.calls[7], 3 )


        assertEquals( m.calls[8][1], 'startTest' )
        assertEquals( m.calls[8][3], 'MyTestWithFailures.testWithFailure2' )
        assertEquals(#m.calls[8], 3 )

        assertEquals( m.calls[9][1], 'addFailure' )
        assertEquals(#m.calls[9], 4 )

        assertEquals( m.calls[10][1], 'endTest' )
        assertEquals( m.calls[10][3], true )
        assertEquals(#m.calls[10], 3 )

        assertEquals( m.calls[11][1], 'endClass' )
        assertEquals(#m.calls[11], 2 )

        assertEquals( m.calls[12][1], 'startClass' )
        assertEquals( m.calls[12][3], 'MyTestOk' )
        assertEquals(#m.calls[12], 3 )

        assertEquals( m.calls[13][1], 'startTest' )
        assertEquals( m.calls[13][3], 'MyTestOk.testOk1' )
        assertEquals(#m.calls[13], 3 )

        assertEquals( m.calls[14][1], 'endTest' )
        assertEquals( m.calls[14][3], false )
        assertEquals(#m.calls[14], 3 )

        assertEquals( m.calls[15][1], 'startTest' )
        assertEquals( m.calls[15][3], 'MyTestOk.testOk2' )
        assertEquals(#m.calls[15], 3 )

        assertEquals( m.calls[16][1], 'endTest' )
        assertEquals( m.calls[16][3], false )
        assertEquals(#m.calls[16], 3 )

        assertEquals( m.calls[17][1], 'endClass' )
        assertEquals(#m.calls[17], 2 )

        assertEquals( m.calls[18][1], 'endSuite' )
        assertEquals(#m.calls[18], 2 )

        assertEquals( m.calls[19], nil )

    end

    function TestLuaUnitExecution:test_filterWithPattern()

        runner = LuaUnit:new()
        runner:setOutputType( "NIL" )
        runner:runSuite('-p', 'Function', '-p', 'Toto.' )
        assertEquals( executedTests[1], "MyTestFunction" )
        assertEquals( executedTests[2], "MyTestToto1:test1" )
        assertEquals( executedTests[3], "MyTestToto1:test2" )
        assertEquals( executedTests[4], "MyTestToto1:test3" )
        assertEquals( executedTests[5], "MyTestToto1:testa" )
        assertEquals( executedTests[6], "MyTestToto1:testb" )
        assertEquals( executedTests[7], "MyTestToto2:test2" )
        assertEquals( #executedTests, 7)
    end
