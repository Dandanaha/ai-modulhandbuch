'use strict'

angular.module('modulmanager')
  .service 'moduleConstructor', ($filter) ->
    addReq = (prototype) ->
      module = prototype
      newReq = prototype.newReq
      if newReq.length < 1 then return
      for oldReq in module.requirements
        if oldReq == newReq then return
      module.requirements.push(newReq)
      prototype.newReq = ''

    addMajor = (prototype) ->
      if prototype.newMajor?.length >=1
        if prototype['other-majors'] then prototype['other-majors'].push(prototype.newMajor) else prototype['other-majors'] = [prototype.newMajor]
        prototype.newMajor = ''

    addQsp = (prototype) ->
      newQsp = {
        __text:prototype.newQsp
        "major-id":-1
      }
      if prototype.newQsp?.length >=1
        if prototype.qsp then prototype.qsp.push(newQsp) else prototype.qsp = [newQsp]
        prototype.newQsp = ''

    addWork = (prototype) ->
      if prototype.newWork?.length >=1
        if prototype.workload then prototype.workload.push(prototype.newWork) else prototype.workload = [prototype.newWork]
        prototype.newWork = ''

    addTarget = (prototype) ->
      if prototype.newTarget?.text.length >=1
        if prototype.description.target
          prototype.description.target.push {
            text:prototype.newTarget.text
            subs:[]
          }
        else
          prototype.description.target = [
            {
              text:prototype.newTarget.text
              subs:[]
            }
          ]
        prototype.newTarget.text = ''

    addSubTarget = (prototype,index) ->
      if prototype.newTarget?.newSub[index]?.length >=1
        if prototype.description.content
          prototype.description.target[index].subs.push prototype.newTarget.newSub[index]
        else
          prototype.description.target[index].subs = [prototype.newContent.newSub[index]]
        prototype.newTarget.newSub[index] = ''

    addContent = (prototype) ->
      if prototype.newContent?.text.length >=1
        if prototype.description.content
          prototype.description.content.push {
            text:prototype.newContent.text
            subs:[]
          }
        else
          prototype.description.content = [
            {
              text:prototype.newContent.text
              subs:[]
            }
          ]
        prototype.newContent.text = ''

    addSubContent = (prototype,index) ->
      if prototype.newContent?.newSub[index]?.length >=1
        if prototype.description.content
          prototype.description.content[index].subs.push prototype.newContent.newSub[index]
        else
          prototype.description.content[index].subs = [prototype.newContent.newSub[index]]
        prototype.newContent.newSub[index] = ''

    addScript = (prototype) ->
      if prototype.newScript?.length >=1
        if prototype.scripts then prototype.scripts.push(prototype.newScript) else prototype.scripts = [prototype.newScript]
        prototype.newScript = ''

    addBook = (prototype) ->
      if prototype.newBook?.length >=1
        if prototype.literature then prototype.literature.push(prototype.newBook) else prototype.literature = [prototype.newBook]
        prototype.newBook = ''

    # @param: yearsAround -> How many years before and after the current year should be added to the list?
    constructOfferList = (yearsAround) ->
      yearsAround = 1 if not yearsAround
      semesters = ['s','w']
      offer = {}
      currentYear = parseInt $filter('date')(new Date(), 'yy')
      for i in [0..yearsAround] by 1
        offer["#{(currentYear-i)}s"]={
          name:"Sommersemester 20#{currentYear-i}"
          year:currentYear-1
        }
        offer["#{(currentYear-i)}w"]={
          name:"Wintersemester 20#{currentYear-i}"
          year:currentYear-1
        }

      for i in [1..yearsAround] by 1
        offer["#{(currentYear+i)}s"]={
          name:"Sommersemester 20#{currentYear+i}"
          year:currentYear+1
        }
        offer["#{(currentYear+i)}w"]={
          name:"Wintersemester 20#{currentYear+i}"
          year:currentYear+1
        }
      return offer

    exTypes:
      "written":"Schriftliche Klausur"
      "practical":"Praktische Studienleistung"
      "oral":"Mündliche Prüfung / Kolloqium"
      "presentation":"Präsentation / Vortrag"
      "paper":"Schriftliche Ausarbeitung"
      "external":"Hochschulexterne Leistungsfeststellung"

    moduleTypes:
      "mandatory":"Pflichtveranstaltung"
      "elective":"Wahlmodul"
      "major":"Qualifikationsschwerpunkt"
      "practical":"Praxissemester"
      "thesis":"Bachelorthesis"

    offer: constructOfferList(2)

    removeReq: (prototype,index) ->
      prototype.requirements.splice(index,1)

    removeQsp: (prototype,index) ->
      prototype.qsp.splice(index,1)

    removeMajor: (prototype,index) ->
      prototype['other-majors'].splice(index,1)

    removeWork: (prototype,index) ->
      prototype.workload.splice(index,1)

    removeTarget: (prototype,index) ->
      prototype.description.target.splice(index,1)

    removeSubTarget: (prototype, parentIndex, index) ->
      prototype.description.target[parentIndex].subs.splice(index,1)

    removeContent: (prototype,index) ->
      prototype.description.content.splice(index,1)

    removeSubContent: (prototype, parentIndex, index) ->
      prototype.description.content[parentIndex].subs.splice(index,1)

    removeScript: (prototype,index) ->
      prototype.scripts.splice(index,1)

    removeBook: (prototype,index) ->
      prototype.literature.splice(index,1)

    checkSeparator: (prototype,e,type,index) ->
      if not index then index = 0
      separatorKeys = ['Enter']
      separatorKeyCodes = [44,13]

      regular = true
      for key in separatorKeys
        if key == e.key then regular = false

      for keyCode in separatorKeyCodes
        if keyCode == e.keyCode then regular = false

      if not regular
        e.preventDefault()
        switch type
          when'req' then addReq(prototype)
          when'qsp' then addQsp(prototype)
          when'major' then addMajor(prototype)
          when'work' then addWork(prototype)
          when'target' then addTarget(prototype)
          when'content' then addContent(prototype)
          when'script' then addScript(prototype)
          when'book' then addBook(prototype)
          when'subContent' then addSubContent(prototype,index)
          when'subTarget' then addSubTarget(prototype,index)
          else console.log 'checkSeparator misuse! You mispelled the type or forgot to declare it'