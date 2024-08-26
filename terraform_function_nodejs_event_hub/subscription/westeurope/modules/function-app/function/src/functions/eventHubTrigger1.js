const { app, output } = require('@azure/functions');

const blobOutput = output.storageBlob({
    connection: 'Storageoutput',
    path: 'container/{rand-guid}.txt',
});

app.eventHub('eventHubTrigger1', {
    connection: 'evhnseventhubprodweu001_RootManageSharedAccessKey_EVENTHUB',
    eventHubName: 'evheventhubprodweu001',
    cardinality: 'many',
    extraOutputs: [blobOutput],
    handler: (messages, context) => {
        if (Array.isArray(messages)) {
            context.log(`Event hub function processed ${messages.length} messages`);
            for (const message of messages) {
                context.log('Event hub message:', message);
            }
        } else {
            context.log('Event hub function processed message:', messages);
        }

        context.extraOutputs.set(blobOutput, "content");
        context.log('Created one text file in the Storage Account container');
    }
});
