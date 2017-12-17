contact = {}

function contact.isInContact(v1,v2)
  return contact.isInRectXRange(v1,v2) and
    contact.isInRectYRange(v1,v2)
end

function contact.isInRectXRange(a,b)
  return a.x < b.x+b.width and b.x<a.x+a.width
end

function contact.isInRectYRange(a,b)
  return a.y < b.y+b.height and b.y<a.y+a.height
end