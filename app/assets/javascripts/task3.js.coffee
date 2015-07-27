root = exports ? this

dragSrcEl = oneMy = clickElement = null

NotstopEl = true

root.forward = () ->
	fd 100

root.back = () ->
	bk 100

root.turnLeft = () ->
	lt 90

root.turnRight = () ->
	rt 90

root.clean = () ->
	cg()

root.penOn = () ->
	pen 'red'

root.penOff = () ->
	pen 'white'

root.showTurtle = () ->
	st() 

root.hideTurtle = () ->
	ht()

root.drawTriangle = () ->
	pen 'red'
	for i in [1..3]
		fd 200
		rt 120

root.drawSquare = () ->
	pen 'red'
	for i in [1..4]
		fd 200
		rt 90

root.changeClickElement = (e) ->
	this.style.opacity = "0.2"
	if clickElement
		clickElement.style.opacity = '1'
	clickElement = this
	clickElement.style.opacity = '0.4'

root.deleteClickedElement = () ->
	if clickElement
		clickElement.outerHTML = ""
		clickElement = null

root.Dragend = (e) ->
	this.innerHTML = dragSrcEl.innerHTML 

root.DragOver = (e) ->
	if e.preventDefault
		e.preventDefault()
	e.dataTransfer.dropEffect = 'move'
	false

root.DragStart = (e) ->
	e.stopPropagation()
	dragSrcEl = this
	e.dataTransfer.effectAllowed = 'move'
	e.dataTransfer.setData 'text/html', @innerHTML

root.Drop = (e) ->
  	if e.stopPropagation
    	e.stopPropagation()
  	if dragSrcEl != this
  		this.innerHTML = this.innerHTML + dragSrcEl.outerHTML
  	false

root.DropInPanel = (e) ->
	if e.stopPropagation
    	e.stopPropagation()
    if dragSrcEl != this
    	dragSrcEl.innerHTML = @innerHTML
    	@innerHTML = e.dataTransfer.getData('text/html')
  	false

MakeOne = () ->
	@editingPanel = document.getElementById("Panel").innerHTML
	@constpart = @editingPanel.substr(0, 27)
	@editingPanel = @editingPanel.substr(28)
	@editingPanel = @editingPanel.substr(@editingPanel.indexOf(">")+2)
	@myAction = @editingPanel.substr(0, @editingPanel.indexOf(")")+1)
	eval @myAction
	@editingPanel = @editingPanel.substr(@editingPanel.indexOf(">")+1) 
	@constpart += @editingPanel
	document.getElementById("Panel").innerHTML = @constpart

root.Step = () ->
	@panelHTML = document.getElementById("Panel").innerHTML
	if @panelHTML.length > 28 
		MakeOne()
		true
	else
		false

root.Run = () ->
	if NotstopEl && Step()
		setTimeout("Run()", 2400)
	else
		NotstopEl = true	

root.Stop = () ->
	NotstopEl = false

