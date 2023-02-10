#!/bin/env io
"hello world" println

FileSys := Object clone
FileSys getDirs := method(
  System runCommand("echo */") stdout split
)

FileSys getDirs foreach(dir, dir println)

Service := Object clone

Service spinUp := method(
  command := "touch #{self directory}/file" interpolate
  System runCommand(command)
)

Service spinDown := method(
  command := "rm #{self directory}/file" interpolate
  System runCommand(command)
)

ServiceManager := Object clone
ServiceManager services := List clone

ServiceManager load := method(
  FileSys getDirs foreach(dir,
    service := Service clone
    service directory := dir exSlice(0,-1)
    self services append(service)
  )
)

ServiceManager load

"Getting dirs from services" println

ServiceManager list := method(
  self services foreach(i, service,
    "#{i}: #{service directory}" interpolate println
  )
)

ServiceManager list
