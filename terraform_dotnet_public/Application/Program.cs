var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.MapGet("/", () => {
    var sharePath = "/home/share";

    if(!Directory.Exists(sharePath)) {
        return "The " + sharePath + " directory does not exist";
    }

    // Create a new file in the shared directory
    Random rnd = new Random();
    int num  = rnd.Next(2000);
    string[] lines = { "Line 1", "Line 2", "Line 3", "Line 4", "Line 5" };
    using (StreamWriter outputFile = new StreamWriter(Path.Combine(sharePath, "shared_" + num + ".txt")))
    {
        foreach (string line in lines)
            outputFile.WriteLine(line);
    }

    // Return the name of the files in the share directory
    string[] files = Directory.GetFiles(sharePath);
    return string.Join(System.Environment.NewLine, files);
});

app.Run();
