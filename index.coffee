# by d4Rk

command: 'git-stats.widget/commands.sh'
refreshFrequency: 600000

update: (output, domEl) ->
  # console.log output
  data = JSON.parse(output)
  $domEl = $(domEl)
  $domEl.html("")

  $domEl.append("<div align='center'>[ git-stats: <span class='name'>#{data.repoName}</span> ]</div><br />")
  $domEl.append("<div>[ <span class='name'>age</span>: #{data.repoAge} ]</div><br />")
  $domEl.append("<div>[ <span class='name'>commits</span>: #{data.commitCount} (#{data.commitsPerDay} per day) ]</div>")
  $domEl.append("<div>[ <span class='name'>top devs</span> ]<br /><table>#{data.commitCountByDev}</table></div><br />")
  $domEl.append("<div>[ <span class='name'>files</span>: #{data.fileCount} ]</div>")
  $domEl.append("<div>[ <span class='name'>top files</span> ] <br /><table>#{data.fileCountByType}</table></div>")

style: """
  left 0%
  bottom 0%
  padding 0
  margin 0
  color #ccc
  font-family Menlo
  font-size 1em
  width 500px
  background-color rgba(0, 0, 0, 0.5) 

  table
    border-collapse collapse

  span.name, th
    font-weight bold
    color lime

  .left
    text-align left

  .right 
    text-align right

  .item
    text-align left

  a
    text-decoration none
    color #ccc
"""
