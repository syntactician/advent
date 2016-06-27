#!/usr/bin/env node
'use strict'

const md5 = require('md5')
const fs = require('fs')

const parse = (str) => str.slice(0, -1)

const shared = (input, test) => {
  const hash = (str) => md5(str).slice(0, test.length)
  let i = 0
  for (; hash(input + i) != test; ++i)
    continue
  return i - 1
}

const sideA = (str) => shared(str, '00000')

const sideB = (str) => shared(str, '000000')

const main = () => {
  const contents = fs.readFileSync('../4.txt', 'utf8')
  const input = parse(contents)
  console.log(sideA(input))
  console.log(sideB(input))
  return
}

main()
