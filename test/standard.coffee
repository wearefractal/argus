argus = require '../'
should = require 'should'
require 'mocha'

testargs = [
  "string", 'string'
  true, false
  2, -2, 0
  2.2, -2.2
  null,#undefined
  [{"test":"test"}],["arr1","arr2"]
  {"test":"~~~test~~"}, {}
]
testcli = JSON.stringify testargs

describe 'parse()', ->
  describe 'standard behaviour', ->
    it 'task(none)', (done) ->
      res = argus.parse "task"
      should.exist res
      should.exist res.task
      res.task.should.eql []
      done()
    it 'task(all)', (done) ->
      res = argus.parse "task#{testcli}"
      should.exist res
      should.exist res.task
      res.task.should.eql testargs
      done()
    it 'task(none):task2(all)', (done) ->
      res = argus.parse "task:task2#{testcli}"
      should.exist res
      should.exist res.task
      res.task.should.eql []
      should.exist res.task2
      res.task2.should.eql testargs
      done()
    it 'task(all):task2(none)', (done) ->
      res = argus.parse "task#{testcli}:task2"
      should.exist res
      should.exist res.task
      res.task.should.eql testargs
      should.exist res.task2
      res.task2.should.eql []
      done()

  describe 'overloading', ->
    it 'task(none):task(all)', (done) ->
      res = argus.parse "task:task#{testcli}"
      should.exist res
      should.exist res.task
      res.task.should.eql testargs
      done()
    it 'task(all):task(none)', (done) ->
      res = argus.parse "task#{testcli}:task"
      should.exist res
      should.exist res.task
      res.task.should.eql []
      done()