import app from "./app.js";
import { connecToDatabase } from "./db/connection.js";
// Connections and listeners
const PORT = process.env.PORT || 5001; // Use the port from the .env file
connecToDatabase()
    .then(() => {
    app.listen(PORT, () => console.log(`Server open and connected to database on port ${PORT}`));
})
    .catch((err) => console.log(err));
//# sourceMappingURL=index.js.map