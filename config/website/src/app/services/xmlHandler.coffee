'use strict'

angular.module('modulmanager')
  .service 'xmlHandler', ($http, $rootScope, $q,x2js,$filter,$window) ->
    parseModule = (module) ->
      # Step 1 - Parse csv string data in Arrays
      module.extype = [module.extype] if not Array.isArray(module.extype)
      module.qsp = [module.qsp] if not Array.isArray(module.qsp)
      module['other-majors'] = module['other-majors']?.split('=NL') if not Array.isArray(module['other-majors'])
      module.workload = module.workload?.split('=NL') if not Array.isArray(module.workload)
      module.scripts = module.scripts?.split('=NL') if not Array.isArray(module.scripts)
      module.literature = module.literature?.split('=NL') if not Array.isArray(module.literature)
      module.requirements = module.requirements?.split(',') if not Array.isArray(module.requirements)
      module['offered-semesters'] = module['offered-semesters'].split(',') if not Array.isArray(module['offered-semesters'])

      # Step 2 - Parse multi-level lists
      targets = module.description.target.split('=NL') if not Array.isArray(module.description.target)
      module.description.target = []
      for target in targets
        target = target.split('=SL')
        module.description.target.push {
          text:target[0] || ''
          subs:target.slice 1
        }

      contents = module.description.content.split('=NL') if not Array.isArray(module.description.content)
      module.description.content = []
      for content in contents
        content = content.split('=SL')
        module.description.content.push {
          text:content[0] || ''
          subs:content.slice 1
        }


      # Step 3 - Initialize empty fields
      module['offered-semesters'] = [] if not module['offered-semesters']?[0].length == 0
      module.extype = [] if module.extype?[0].length == 0
      module['other-majors'] = [] if module['other-majors']?[0].length == 0
      module.workload = [] if module.workload?[0].length == 0
      module.requirements = [] if module.requirements?[0].length == 0
      module.description.target = [] if module.description.target?[0].length == 0
      module.description.content = [] if module.description.content?[0].length == 0
      module.scripts = [] if module.scripts?[0].length == 0
      module.literature = [] if module.literature?[0].length == 0
      return module

    parseModules = (modules) ->
      for part in modules.part
        part.sub = [part.sub] if not Array.isArray(part.sub)
        if not part.description then part.description = ''
        for sub in part.sub
          sub.module = [sub.module] if not Array.isArray(sub.module)
          if not sub.description then sub.description = ''
          for module in sub.module
            module = parseModule(module)
      console.log modules
      return modules

    # The multilevel lists need to be merged into a single string
    listToString = (list) ->
      if not list then return ''
      result = []
      for elem in list
        subs = elem.subs.join '=SL'
        elem = elem.text
        if subs.length > 0 then elem+='=SL'+subs
        result.push elem
      return result.join '=NL'

    getModuleXml: () ->
      result = $q.defer()
      # url = 'http://ai.it.hs-worms.de/mm/mm.xml'
      url = 'assets/data/hs-data.xml'
      $http.get url
      .success (resp) ->
        hsData = x2js.xml_str2json resp
        $rootScope.hsData = hsData.xml
        result.resolve(parseModules(hsData.xml.modules))
        console.log $rootScope.hsData
      .error (error) ->
        result.reject error
      return result

    parseModulesFromFile: (f) ->
      console.log f
      result = $q.defer()
      url = URL.createObjectURL f
      $http.get url
      .success (resp) ->
        hsData = x2js.xml_str2json resp
        $rootScope.hsData = hsData.xml
        result.resolve(parseModules(hsData.xml.modules))
        console.log $rootScope.hsData
      .error (error) ->
        result.reject error
      return result

    exportModuleList : (modules,scope) ->
      # Construct object according to desired data structure in the target xml file
      # This needs to be done step-by-step because the generated angular.js
      # watchers and hashes break the xml structure
      # This is the actual representation of the source data structure
      list = {
        xml:
          _version:'1.0'
          _encoding:'UTF-8'
          info:
            created:'02-23-2015;11:36:00'
            changed: $filter('date')(new Date(), 'MM-dd-yyyy;hh:mm:ss')
            revision: parseInt($rootScope.hsData.info.revision)+1
            owner: 'admin via web interface'
          modules:
            part:({
              _code: part._code
              _name: part._name
              description: part.description || ''
              sub:({
                _code: sub._code
                _name: sub._name
                description: sub.description || ''
                module:({
                  _code: module.name.code
                  name: module.name
                  sem: module.sem
                  type: module.type
                  qsp: module.qsp
                  'offered-semesters': module['offered-semesters']?.join ','
                  requirements: module.requirements?.join ','
                  'other-majors': module['other-majors']?.join '=NL'
                  professor: module.professor || module.responsible || ''
                  responsible: module.responsible || module.professor || ''
                  lang:module.lang || 'Deutsch'
                  pts: module.pts
                  workload: module.workload?.join '=NL' || []
                  sws: module.sws || ''
                  extype: module.extype
                  weight: module.weight || 'Entsprechend der ECTS-Punkte'
                  description:
                    target: listToString(module.description.target)
                    content: listToString(module.description.content)
                  methods: module.methods || ''
                  special: module.special || ''
                  scripts: module.scripts?.join '=NL' || []
                  literature: module.literature?.join '=NL' || []
                } for module in sub.module)
              } for sub in part.sub)
            }for part in modules.part)
      }

      # Create xml file
      list = x2js.json2xml_str list

      # Link xml file to new DOM element
      blob = new Blob([list], { type:"text/xml;charset=utf-8;" })
      downloadLink = angular.element('<a></a>')
      downloadLink.attr('href',$window.URL.createObjectURL(blob))
      downloadLink.attr('download', 'hs-data.xml')

      # Trigger download
      if document.createEvent
        ev = document.createEvent("MouseEvent")
        ev.initMouseEvent(
          "click",
          true, true,
          window, null,
          0, 0, 0, 0,
          false, false, false, false,
          0, null
        )
        downloadLink[0].dispatchEvent(ev)
      else
        downloadLink[0].fireEvent("onclick")
