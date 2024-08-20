# Example ASP.NET application using .NET 8

The following project contains one example ASP.NET web application built in .NET 8.
The URL namespace of web application creates one random file in a share folder.

## Development

### Build Application

```sh
dotnet build DotNetExample1.csproj -c Release
```

### Run Application Locally

```sh
dotnet ./bin/Release/net8.0/DotNetExample1.dll
```

### Publish application

```sh
dotnet publish -c Release -o out
```
