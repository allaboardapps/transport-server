SELECT
  row_number() OVER () AS id PRIMARY KEY,
  stations.mapid AS mapid,
  stations.stopid AS stopid,
  stations.name AS station_name,
  routes.lowerid AS route_name,
  directions.name AS direction_name,
  stations.id AS station_id,
  routes.id AS route_id,
  directions.id AS direction_id,
  stations.diction AS station_diction,
  routes.diction AS route_diction,
  directions.diction AS direction_diction
FROM
  stations
INNER JOIN
  directions
  ON directions.id = stations.direction_id
INNER JOIN
  routes
  ON routes.id = stations.route_id
WHERE
  stations.fake = false
  AND routes.fake = false
  AND directions.fake = false
