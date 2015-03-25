angular.module "modulmanager"
  .controller "ManageModulesCtrl", ($scope, $rootScope, xmlHandler,$document, $mdDialog, $q, moduleConstructor) ->
    
    $rootScope.pageTitle = 'manage module resource - Modulmanager'
    $scope.ui = {
      filterOpts: {
        'title':'Titel'
        'abbr':'Abkürzung'
        'code':'Code'
        'prof':'Dozent'
      }
      strict:false
      filterName: 'abbr'
      filterObj:{name:{}}
      editModule: {
        'part':-1
        'sub':-1
        'module':-1
        'code':'-1'
      }
      activeTab:2
    }

    $scope.checkStrict = ->
      if $scope.ui.filterName
        $scope.ui.strict = ($scope.ui.filterName == 'code' && $scope.ui.filterObj?.name?.code?.length > 0)
      else
        $scope.ui.strict = false
    
    $scope.eraseFilters = ->
      $scope.ui.filterObj.name = {}
      $scope.checkStrict()

    $scope.exTypes = moduleConstructor.exTypes
    $scope.moduleTypes = moduleConstructor.moduleTypes
    $scope.offer = moduleConstructor.offer


    $scope.discardChanges = () ->
      if $scope.ui.editModule.code1 != '-1'
        $scope.modules.part[$scope.ui.editModule['part']].sub[$scope.ui.editModule['sub']].module[$scope.ui.editModule['module']] = $scope.backup
      $scope.ui.editModule= {
        'part':-1
        'sub':-1
        'module':-1
        'code1':'-1'
        'code2':'-1'
        'code3':'-1'
      }

    $scope.removeModule = (part,sub,modu) ->
      if window.confirm "Wollen Sie '#{$scope.modules.part[part].sub[sub].module[modu].name.title}' dauerhaft aus dem Modulhandbuch entfernen?"
        console.log $scope.modules.part[part].sub[sub]
        $scope.modules.part[part].sub[sub].module.splice(modu,1)
      

    $scope.setEditMode = (part, sub, modu, code) ->
      $scope.discardChanges()
      codeFragments = code.split('.')
      if codeFragments.length == 1 then codeFragments.push('1','1')
      if codeFragments.length == 2 then codeFragments.splice(1,0,'1')

      $scope.ui.editModule= {
        'part': part
        'sub':  sub
        'module': modu
        'code1': codeFragments[0]
        'code2': "#{codeFragments[0]}.#{codeFragments[2]}"
        'code3': "#{codeFragments[0]}.#{codeFragments[1]}.#{codeFragments[2]}"
      }
      console.log $scope.ui.editModule
      # Copy selected object to make changes reversible
      $scope.backup = angular.copy $scope.modules.part[part].sub[sub].module[modu]
      $scope.prototype = angular.copy $scope.modules.part[part].sub[sub].module[modu]

      # convert lowercase extype to camelCase exTypes which is used by checkbox input
      $scope.prototype.exTypes = {}
      # Parse csv extype in single booleans for the checkboxes
      for extype in $scope.prototype.extype
        $scope.prototype.exTypes[extype]=true

      $scope.prototype.offeredSem = {}
      for offered in $scope.prototype['offered-semesters']
        $scope.prototype.offeredSem[offered]=true

      console.log $scope.prototype

    resetPrototype = ->
      $scope.prototype = {}
      $scope.backup = {}
      $scope.conflict = {}
      $scope.ui.editModule = {
        'part':-1
        'sub':-1
        'module':-1
        'code1':'-1'
        'code2':'-1'
        'code3':'-1'
      }

    # Used for appending module to end of category
    getLastModuleCode = (part,sub) ->
      lastModule = $scope.modules.part[part].sub[sub].module
      lastModuleCode = lastModule[lastModule.length-1].name.code.split '.'
      lastModuleCodeFragment = parseInt(lastModuleCode[lastModuleCode.length-1])
      result =
        index:
          part: part
          sub: sub
          modul: lastModuleCodeFragment+1
        code: "#{part+1}.#{sub+1}.#{lastModuleCodeFragment+1}"
      return result

    appendModule = (appendCode) ->
      $scope.modules.part[appendCode.index.part].sub[appendCode.index.sub].module.push module

    moveModuleAppend = (appendCode) ->
      module = $scope.modules.part[$scope.ui.editModule['part']].sub[$scope.ui.editModule['sub']].module.splice([$scope.ui.editModule['module']],1)[0]
      module.name.code =  module.code = appendCode.code
      appendModule()

    applyChange = () ->
      $scope.modules.part[$scope.ui.editModule['part']].sub[$scope.ui.editModule['sub']].module[$scope.ui.editModule['module']] = $scope.prototype
      resetPrototype()

    $scope.commitChanges = () ->
      module = $scope.prototype

      module.extype = []
      # Parse single booleans from checkboxes in csv for xml export
      for key, value of $scope.prototype.exTypes
        module.extype.push(key) if value

      module['offered-semesters'] = []
      for key, value of $scope.prototype.offeredSem
        module['offered-semesters'].push(key) if value

      mode = 'edit'
      # Check, if old module is not the one that was edited
      # Possibly in a conflict in module codes
      if $scope.prototype.name.code != $scope.backup?.name.code
        $scope.conflict = {}
        for part,pI in $scope.modules.part
          for sub,sI in part.sub
            for modul in sub.module
              if modul.name.code == $scope.prototype.name.code
                # Conflicting module detected!
                # Begin with conflict handling by showing dialogue
                appendCode = getLastModuleCode(pI,sI)
                $scope.prototype.appendCode = appendCode.code
                $scope.conflict = modul

        if $scope.conflict.name
          $scope.showOverwriteDialog().then (answer) ->
            mode = answer
            console.log mode
            # Assign prototype to module
            switch mode
              when 'back','cancel'
                console.log 'Back to edit mode!'
              when 'discard'
                resetPrototype()
              when 'append'
                # Set Module Code to last in this collection
                moveModuleAppend(appendCode)
                resetPrototype()
              else
                console.log 'Something went wrong while writing! Mode is not properly set'
        else
          applyChange()
      else
        applyChange()

    $scope.removeReq = (index) ->
      moduleConstructor.removeReq($scope.prototype,index)

    $scope.removesp = (index) ->
      moduleConstructor.removesp($scope.prototype,index)

    $scope.removeMajor = (index) ->
      moduleConstructor.removeMajor($scope.prototype,index)

    $scope.removeWork = (index) ->
      moduleConstructor.removeWork($scope.prototype,index)

    $scope.removeTarget = (index) ->
      moduleConstructor.removeTarget($scope.prototype,index)

    $scope.removeContent = (index) ->
      moduleConstructor.removeContent($scope.prototype,index)

    $scope.removeScript = (index) ->
      moduleConstructor.removeScript($scope.prototype,index)

    $scope.removeBook = (index) ->
      moduleConstructor.removeBook($scope.prototype,index)

    $scope.checkSeparator = (e,type) ->
      moduleConstructor.checkSeparator($scope.prototype,e,type)

    $scope.modules = [
    ]

    $scope.saveJSON = ->
      blob = new Blob([angular.toJson($scope.modules)], { type:"application/json;charset=utf-8;" })
      downloadLink = angular.element('<a></a>')
      downloadLink.attr('href',window.URL.createObjectURL(blob))
      downloadLink.attr('download', 'Modules.json')
      downloadLink[0].click()

    $scope.exportXml = ->
      xmlHandler.exportModuleList($scope.modules, $scope)

    $document.ready () ->
      $scope.ui.editModule= {
        'part':-1
        'sub':-1
        'module':-1
        'code1':'-1'
        'code2':'-1'
        'code3':'-1'
      }

    $scope.showOverwriteDialog = () ->
      result = $q.defer()
      $mdDialog.show
        controller: overwriteDialogController
        templateUrl: 'app/views/overwrite-dialog.html'
        locals:{
          prototype: $scope.prototype
          conflict: $scope.conflict
        }
      .then (answer) ->
        result.resolve(answer)
      , () ->
        result.resolve('cancel')
      return result.promise

    $scope.showImportDialog = () ->
      console.log 'Show import dialog'
      result = $q.defer()
      $mdDialog.show
        controller: importDialogController
        templateUrl: 'app/views/import-dialog.html'
      .then (answer) ->
        console.log answer
        switch answer.mode
          when 'import'
            xmlHandler.getModuleXml().promise.then (resp) ->
              $scope.modules = resp
            , (resp) ->
              console.log resp
              alert 'No xml data found!'
          when 'local'
            xmlHandler.parseModulesFromFile(answer.file).promise.then (resp) ->
              console.log resp
              $scope.modules = resp
            , (resp) ->
              console.log resp
              alert 'No xml data found!'
      , () ->
        console.log 'cancel'


    getCatList = (modules) ->
      catList = []
      for cPart,pI in modules.part
        for cSub,sI in cPart.sub
          lastModule = 0
          for modul in cSub.module
            lastModule++
          catList.push {
            part:
              name: "#{cPart._code} - #{cPart._name}"
              code: cPart._code
              index: pI
            sub:
              name:"#{cSub._code} - #{cSub._name}"
              code:cSub._code
              index: sI
            lastModuleIndex: parseInt(getLastModuleCode(pI,sI).index.modul)-1
          }
      return catList


    $scope.showNewModuleDialog = () ->
      $mdDialog.show
        controller: newModuleDialogController
        templateUrl: 'app/views/new-module-dialog.html'
        locals:
          catList: getCatList($scope.modules)
      .then (answer) ->
        $scope.modules.part[answer.part.index].sub[answer.sub.index].module.push {
          name:
            abbr:'---'
            title:'Neues Modul'
            code:"#{answer.sub.code}.#{answer.lastModuleIndex+1}"
          sem:''
          type: ''
          qsp: ''
          'offered-semesters': []
          'other-majors': []
          requirements:[]
          professor:''
          responsible:''
          lang:''
          pts:''
          workload: []
          sws:''
          extype:[]
          weight:''
          description:
            content:[]
            target:[]
          methods:''
          special:''
          scripts:[]
          literature:[]
        }
      , () ->
        console.log 'Cancel'

    overwriteDialogController = ($scope, $mdDialog, prototype, conflict) ->
      $scope.prototype = prototype
      $scope.conflict = conflict
      
      $scope.hide = ->
        $mdDialog.hide()

      $scope.cancel = ->
        $mdDialog.cancel()

      $scope.answer = (answer)->
        $mdDialog.hide(answer)

    newModuleDialogController = ($scope, $mdDialog,moduleConstructor,catList) ->
      $scope.catList = catList

      $scope.discardChanges = () ->
        $mdDialog.cancel()

      $scope.addModule = () ->
        $mdDialog.hide $scope.selectedCat

    importDialogController = ($scope, $mdDialog) ->
      console.log 'I\'m the import controller'
      $scope.answer = (mode) ->
        switch mode
          when 'local'
            moduleData = document.getElementById 'localXml'
            if moduleData.files.length <=0 or not moduleData.files[0] then return
            $mdDialog.hide
              file:moduleData.files[0]
              mode:mode
          when 'import'
            $mdDialog.hide
              file:{}
              mode:mode
          else
            $mdDialog.hide()