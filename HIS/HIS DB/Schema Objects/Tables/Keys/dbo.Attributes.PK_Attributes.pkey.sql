﻿ALTER TABLE [dbo].[Attributes]
    ADD CONSTRAINT [PK_Attributes] PRIMARY KEY CLUSTERED ([attribute_id] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);

