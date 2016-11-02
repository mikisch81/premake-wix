--
-- Name:        premake-wix/actions/vstudio.lua
-- Purpose:     Define the WIX language Visual Studio action(s).
-- Author:      Michael Schwarcz
-- Created:     2016/10/31
-- Copyright:   (c) 2016 Michael Schwarcz
--

	local p = premake

	local vstudio = p.vstudio
	local project = p.project

	local validation = p.validation

--
-- Patch the vstudio actions with WIX support...
--

	for k,v in pairs({ "vs2005", "vs2008", "vs2010", "vs2012", "vs2013", "vs2015" }) do
		local vs = p.action.get(v)

		if vs ~= nil then
			table.insert( vs.valid_languages, p.WIX )
		end
	end

--
-- Patch the vstudio functions with WIX support...
--

	p.override(vstudio, "projectfile", function(oldfn, prj)
		if project.iswix(prj) then
			return p.filename(prj, ".wixproj")
		end
		return oldfn(prj)
	end)

	p.override(vstudio, "tool", function(oldfn, prj)
		if project.iswix(prj) then
			return "930C7802-8A8C-48F9-8165-68863BCCD9DD"
		end
		return oldfn(prj)
	end)

--
-- Patch the configSupportsKind validation function with WIX support...
--

	p.override(validation, "configSupportsKind", function(oldfn, cfg)
		-- makefile configuration can only appear in C++ projects; this is the
		-- default now, so should only be a problem if overridden.
		if (cfg.kind == p.MAKEFILE) and not p.project.iscpp(cfg.project) then
			p.error("project '%s' uses %s kind in configuration '%s'; language must be C++", cfg.project.name, cfg.kind, cfg.name)
		end

		if project.iswix(cfg.project) and not cfg.project.external then
			p.error("Project '%s' language is set to WIX but not declared as 'externalproject'", cfg.project.name)
		end
	end)