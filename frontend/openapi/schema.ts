/**
 * This file was auto-generated by openapi-typescript.
 * Do not make direct changes to the file.
 */

export interface paths {
    "/comments": {
        parameters: {
            query?: never;
            header?: never;
            path?: never;
            cookie?: never;
        };
        /** Get Comments */
        get: {
            parameters: {
                query?: never;
                header?: never;
                path?: never;
                cookie?: never;
            };
            requestBody?: never;
            responses: {
                /** @description comment found */
                200: {
                    headers: {
                        [name: string]: unknown;
                    };
                    content: {
                        "application/json": {
                            id: number;
                            store_name: string;
                            prostutite_name: string;
                            comment: string;
                            publication_date: Record<string, never>;
                        }[];
                    };
                };
            };
        };
        put?: never;
        post?: never;
        delete?: never;
        options?: never;
        head?: never;
        patch?: never;
        trace?: never;
    };
    "/comparison_report": {
        parameters: {
            query?: never;
            header?: never;
            path?: never;
            cookie?: never;
        };
        /** Get Comparison Report */
        get: {
            parameters: {
                query: {
                    stores: unknown[];
                    message: string;
                    room_id: string;
                };
                header?: never;
                path?: never;
                cookie?: never;
            };
            requestBody?: never;
            responses: {
                /** @description Comparison Report found */
                200: {
                    headers: {
                        [name: string]: unknown;
                    };
                    content: {
                        "application/json": {
                            id: number;
                            value: string;
                            /** @enum {string} */
                            role: "user" | "assistant";
                        }[];
                    };
                };
            };
        };
        put?: never;
        post?: never;
        delete?: never;
        options?: never;
        head?: never;
        patch?: never;
        trace?: never;
    };
    "/rooms": {
        parameters: {
            query?: never;
            header?: never;
            path?: never;
            cookie?: never;
        };
        /** Get Rooms */
        get: {
            parameters: {
                query?: never;
                header?: never;
                path?: never;
                cookie?: never;
            };
            requestBody?: never;
            responses: {
                /** @description room list */
                200: {
                    headers: {
                        [name: string]: unknown;
                    };
                    content: {
                        "application/json": {
                            list: {
                                id: number;
                                user_id: number;
                                name: string | null;
                                created_at: string;
                                updated_at: string;
                                store1_id: number | null;
                                store2_id: number | null;
                            }[];
                        };
                    };
                };
            };
        };
        put?: never;
        /** Create Room */
        post: {
            parameters: {
                query?: never;
                header?: never;
                path?: never;
                cookie?: never;
            };
            requestBody: {
                content: {
                    "application/json": {
                        user_id: number;
                    };
                };
            };
            responses: {
                /** @description room created */
                200: {
                    headers: {
                        [name: string]: unknown;
                    };
                    content: {
                        "application/json": {
                            id: number;
                        };
                    };
                };
            };
        };
        delete?: never;
        options?: never;
        head?: never;
        patch?: never;
        trace?: never;
    };
    "/rooms/{room_id}": {
        parameters: {
            query?: never;
            header?: never;
            path?: never;
            cookie?: never;
        };
        /** Get Room */
        get: {
            parameters: {
                query?: never;
                header?: never;
                path: {
                    room_id: string;
                };
                cookie?: never;
            };
            requestBody?: never;
            responses: {
                /** @description room found */
                200: {
                    headers: {
                        [name: string]: unknown;
                    };
                    content: {
                        "application/json": {
                            id: number;
                            name: string | null;
                            store1?: {
                                id: number;
                                name: string;
                            };
                            store2?: {
                                id: number;
                                name: string;
                            };
                        };
                    };
                };
            };
        };
        put?: never;
        post?: never;
        /** Delete Room */
        delete: {
            parameters: {
                query?: never;
                header?: never;
                path: {
                    room_id: string;
                };
                cookie?: never;
            };
            requestBody?: never;
            responses: {
                /** @description room updated */
                200: {
                    headers: {
                        [name: string]: unknown;
                    };
                    content?: never;
                };
            };
        };
        options?: never;
        head?: never;
        /** Update Room */
        patch: {
            parameters: {
                query?: never;
                header?: never;
                path: {
                    room_id: string;
                };
                cookie?: never;
            };
            requestBody: {
                content: {
                    "application/json": {
                        name: string | null;
                        store1_id: number | null;
                        store2_id: number | null;
                    };
                };
            };
            responses: {
                /** @description room updated */
                200: {
                    headers: {
                        [name: string]: unknown;
                    };
                    content?: never;
                };
            };
        };
        trace?: never;
    };
    "/stores": {
        parameters: {
            query?: never;
            header?: never;
            path?: never;
            cookie?: never;
        };
        /** Get Stores */
        get: {
            parameters: {
                query?: {
                    keyword?: string;
                };
                header?: never;
                path?: never;
                cookie?: never;
            };
            requestBody?: never;
            responses: {
                /** @description store found */
                200: {
                    headers: {
                        [name: string]: unknown;
                    };
                    content: {
                        "application/json": {
                            list: {
                                id: number;
                                store_name: string;
                                address: {
                                    prefecture: string;
                                    municipality: string;
                                };
                                home_page: string;
                                store_image?: string;
                                open: {
                                    from?: string;
                                    to?: string;
                                };
                            }[];
                        };
                    };
                };
            };
        };
        put?: never;
        post?: never;
        delete?: never;
        options?: never;
        head?: never;
        patch?: never;
        trace?: never;
    };
}
export type webhooks = Record<string, never>;
export interface components {
    schemas: never;
    responses: never;
    parameters: never;
    requestBodies: never;
    headers: never;
    pathItems: never;
}
export type $defs = Record<string, never>;
export type operations = Record<string, never>;
