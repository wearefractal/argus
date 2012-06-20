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

describe 'simple()', ->
  describe 'standard behaviour', ->
    it 'task(none)', (done) ->
      res = argus.simple "task"
      should.exist res
      should.exist res.task
      res.task.should.eql []
      done()
    it 'task(all)', (done) ->
      res = argus.simple "task=#{testcli}"
      should.exist res
      should.exist res.task
      res.task.should.eql testargs
      done()
    it 'task(simple)', (done) ->
      res = argus.simple "task=test"
      should.exist res
      should.exist res.task
      res.task.should.eql "test"
      done()
    it 'task(bool)', (done) ->
      res = argus.simple "task=true"
      should.exist res
      should.exist res.task
      res.task.should.eql true
      done()
    it 'task(str)', (done) ->
      res = argus.simple "task=\"test lol\""
      should.exist res
      should.exist res.task
      res.task.should.eql "test lol"
      done()
    it 'task(none):task2(simple)', (done) ->
      res = argus.simple "task:task2=test"
      should.exist res
      should.exist res.task
      res.task.should.eql []
      should.exist res.task2
      res.task2.should.eql "test"
      done()
    it 'task(none):task2(all)', (done) ->
      res = argus.simple "task:task2=#{testcli}"
      should.exist res
      should.exist res.task
      res.task.should.eql []
      should.exist res.task2
      res.task2.should.eql testargs
      done()
    it 'task(all):task2(none)', (done) ->
      res = argus.simple "task=#{testcli}:task2"
      should.exist res
      should.exist res.task
      res.task.should.eql testargs
      should.exist res.task2
      res.task2.should.eql []
      done()

  describe 'overloading', ->
    it 'task(none):task(all)', (done) ->
      res = argus.simple "task:task=#{testcli}"
      should.exist res
      should.exist res.task
      res.task.should.eql testargs
      done()
    it 'task(all):task(none)', (done) ->
      res = argus.simple "task=#{testcli}:task"
      should.exist res
      should.exist res.task
      res.task.should.eql []
      done()

    it 'task(none):task(simple)', (done) ->
      res = argus.simple "task:task=test"
      should.exist res
      should.exist res.task
      res.task.should.eql "test"
      done()
    it 'task(all):task(simple)', (done) ->
      res = argus.simple "task=test:task"
      should.exist res
      should.exist res.task
      res.task.should.eql []
      done()