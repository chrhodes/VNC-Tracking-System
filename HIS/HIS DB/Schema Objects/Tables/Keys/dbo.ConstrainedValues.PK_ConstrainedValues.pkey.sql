﻿ALTER TABLE [dbo].[ConstrainedValues]
    ADD CONSTRAINT [PK_ConstrainedValues] PRIMARY KEY CLUSTERED ([constrainedvalue_id] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);
