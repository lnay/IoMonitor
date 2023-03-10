#!/usr/bin/env io

FileSys := Object clone
FileSys getDirs := method(
  System runCommand("echo */") stdout split
)

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
  self services empty
  FileSys getDirs foreach(dir,
    service := Service clone
    service directory := dir exSlice(0,-1)
    self services append(service)
  )
)

ServiceManager load

ServiceManager list := method(
  self services foreach(i, service,
    "#{i}:    #{service directory}" interpolate println
  )
)

File standardInput foreachLine(line, ServiceManager doString(line) )
