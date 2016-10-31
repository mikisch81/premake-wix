--
-- Name:        premake-wix/_preload.lua
-- Purpose:     Define the WIX language API's.
-- Author:      Michael Schwarcz
-- Created:     2016/10/31
-- Copyright:   (c) 2016 Michael Schwarcz
--

	local p = premake
	local api = p.api

--
-- Register the WIX extension
--

	p.WIX = "wix"

	api.addAllowed("language", p.WIX)

--
-- Decide when to load the full module
--

	return function (cfg)
		return (cfg.language == p.WIX)
	end
