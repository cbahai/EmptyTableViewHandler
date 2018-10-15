# EmptyTableViewHandler
handle UItableView when data is empty

## Requirements

- iOS 8.0+
- Swift 4

## Installation

### Carthage

You can use [Carthage](https://github.com/Carthage/Carthage) to install `EmptyTableViewHandler` by adding it to your `Cartfile`:
```
github "cbahai/EmptyTableViewHandler"
```

## Usage

```swift
import EmptyTableViewHandler
```

```swift
self.emptyTableViewHandler = EmptyTableViewHandler(tableView: self.tableView)
self.emptyTableViewHandler.reloadData(with: self.emptyView)
```
