--
-- Name:        premake-wix/wix.lua
-- Purpose:     Define the WIX language action(s).
-- Author:      Michael Schwarcz
-- Created:     2016/10/31
-- Copyright:   (c) 2016 Michael Schwarcz
--

	local p = premake

	p.modules.wix = {}

	local m = p.modules.wix


--
-- Patch the project table to provide knowledge of WIX projects
--
	function p.project.iswix(prj)
		return prj.language == premake.WIX
	end

--
-- Patch the path table to provide knowledge of WIX file extenstions
--
	function path.iswixfile(fname)
		return path.hasextension(fname, { ".wixproj" })
	end


--
-- Patch actions
--

	include( "_preload.lua" )
	include( "actions/vstudio.lua" )

	return m