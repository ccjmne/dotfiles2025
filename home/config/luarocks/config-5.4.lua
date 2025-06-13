home_tree = os_getenv("LUAROCKS_HOME") or (os_getenv("XDG_DATA_HOME") .. "/luarocks")

rocks_trees = {
  { name = "user", root = home_tree },
}

variables = {
  LUA_PATH = os_getenv("LUA_PATH"),
  LUA_CPATH = os_getenv("LUA_CPATH"),
}
