[![license-badge](https://img.shields.io/badge/license-MIT-blue.svg)](https://img.shields.io/badge/license-MIT-blue.svg)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)

# Table of Contents

- [Demo](#demo)
- [Description](#description)
  - [Details](#details) 
- [Installation](#installation)
  - [Baseline String](#baseline-string)
- [Implementation notes](#implementation-note)
- [Contribute](#contribute)
  - [Version management](#version-management)
- [License](#license)

# Demo

https://github.com/user-attachments/assets/21fd3129-db53-4fc9-8ea8-f866882df9c5

# Description

Pinner is a Spec application that displays your Pharo's browsing history. It works with the Calypso browser but could be easily adapted for use with other tools. 

The idea is that you browse packages, classes, and methods as always, and Pinner collects this history along with its occurrences. The Pinner UI could be shown or hidden, but the collector still works by pinning visited objects in your browsers. When the Pinner window is opened, clicking on a pinned package will filter and display the classes and methods visited in that package. Clicking in a pinned class will filter and display the methods in that class that were visited.

## Features

- Sorting: You can sort packages, classes, and methods by name by clicking on the header of each table. Similarly, you can sort by visit count by clicking on the # at the header of each table.
- Supports multiple browser visiting history collection.
- Different versions of a visited method count as a single method. This means that visiting, modifying, and revisiting a method are not stored as two separate entries in the history collector. So, in this case, it will be counted as two visits to the same method.
- Reset global history, or reset pinned objects by category.

## Usage notes

- Visiting items (packages, classes, and methods) outside the browser (Calypso by default) does not register them as part of the history, and clicking items on other tools like Iceberg, Epicea, or Inspectors does not register them by default.
- Double-click on the currently selected item to unselect any item in the Pinner.

# Installation

```smalltalk
EpMonitor disableDuring: [ 
	Metacello new	
		baseline: 'Pinner';	
		repository: 'github://hernanmd/pinner/src';	
		load ].
```

## Baseline String 

If you want to add the Pinner to your Metacello Baselines or Configurations, copy and paste the following expression:
```smalltalk
	" ... "
	spec
		baseline: 'Pinner' 
		with: [ spec repository: 'github://hernanmd/pinner/src' ];
	" ... "
```

# Usage

- Go to Library -> Pinner to open the Pinner window.
- To stop collecting data, open the Settings Browser and select **ClyNavigationHistory** in the "Navigation History" setting.
- To open the Pinner UI programmatically:

```smalltalk
PinnerSpApplication startApplication
```

# Contribute

**Working on your first Pull Request?** You can learn how from this *free* series [How to Contribute to an Open Source Project on GitHub](https://egghead.io/series/how-to-contribute-to-an-open-source-project-on-github)

If you have discovered a bug or have a feature suggestion, feel free to create an issue on Github.
If you have any suggestions for how this package could be improved, please get in touch or suggest an improvement using the GitHub issues page.
If you'd like to make some changes yourself, see the following:    

  - Fork this repository to your own GitHub account and then clone it to your local device
  - Do some modifications
  - Test.
  - Add <your GitHub username> to add yourself as author below.
  - Finally, submit a pull request with your changes!
  - This project follows the [all-contributors specification](https://github.com/kentcdodds/all-contributors). Contributions of any kind are welcome!

## Version management 

This project use semantic versioning to define the releases. This means that each stable release of the project will be assigned a version number of the form `vX.Y.Z`. 

- **X** defines the major version number
- **Y** defines the minor version number 
- **Z** defines the patch version number

When a release contains only bug fixes, the patch number increases. When the release contains new features that are backward compatible, the minor version increases. When the release contains breaking changes, the major version increases. 

Thus, it should be safe to depend on a fixed major version and moving minor version of this project.

# License
	
This software is licensed under the MIT License.

Copyright Hernán Morales Durand, '2024'.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Authors

Hernán Morales Durand
