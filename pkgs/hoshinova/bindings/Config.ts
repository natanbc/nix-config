// This file was generated by [ts-rs](https://github.com/Aleph-Alpha/ts-rs). Do not edit this file manually.
import type { ChannelConfig } from "./ChannelConfig";
import type { NotifierConfig } from "./NotifierConfig";
import type { ScraperConfig } from "./ScraperConfig";
import type { WebserverConfig } from "./WebserverConfig";
import type { YtarchiveConfig } from "./YtarchiveConfig";

export interface Config { ytarchive: YtarchiveConfig, scraper: ScraperConfig, notifier: NotifierConfig | null, webserver: WebserverConfig | null, channel: Array<ChannelConfig>, }