local function shallowCopy(t)
  local x = {}
  for i,v in pairs(t) do x[i]=v end
  return x
end

function class_new(name)
  local new_class = {}
  new_class.__index = new_class
  function new_class.newObject(...)
    local sup = new_class:superClass()
    local newinst = sup == nil and {} or sup.new(...)
    setmetatable(newinst, new_class)
    return newinst
  end
  new_class.new = new_class.newObject
  
  function new_class:class()
    return new_class
  end
  function new_class:name()
    return (name == nil and "unknown" or name)
  end
  function new_class:superClass()
    return nil
  end
  function new_class:superClasses()
    local classes = {}
    local curr_class = new_class:superClass()
    while curr_class ~= nil do
      table.insert(classes,curr_class)
      curr_class = curr_class:superClass()
    end
    return classes
  end
  
  function new_class:is_a(someClass)
    local cur_class = new_class
    while cur_class ~= nil do
      if cur_class == someClass then return true
      else cur_class = cur_class:superClass() end
    end
    return false
  end
  
  return new_class
end

function class_extends(baseClass,name)
  local new_class = class_new(name)
  if baseClass~=nil then 
    setmetatable(new_class,baseClass)
    function new_class:superClass()
      return baseClass
    end
    --[[
    function new_class:super()
      local x = {}
      for i,v in pairs(baseClass) do
        x[i] = inst:v
      end
      setmetatable(x,baseClass)
      return x
    end
    ]]
    --new_class.superClass = baseClass
    --new_class.super = {}
    --[[
    for i,v in pairs(baseClass) do
      new_class[]--super[i] = v
    end
    setmetatable(new_class.super,getmetatable(baseClass))
    ]]
  end
  return new_class
end